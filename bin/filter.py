#!/usr/bin/env python3

import argparse
import io
import os
import re
import sys
from typing import List, Union
from typing import Optional
from typing import Tuple


TreeNode = Union[Tuple[int, str, List['TreeNode']], Tuple[int, str]]

def print_tree(tree: List[TreeNode], level: int = 1) -> None:
    for node in tree:
        match node:
            case (number, title, [*subtree]):
                print(f'{number}:{"#" * level} {title}')
                print_tree(subtree, level=level + 1)

            case (number, line) if line:
                print(f'{number}:{line}')

            case (number, ""):
                print()


def filter_tree(tree: List[TreeNode]) -> List[TreeNode]:
    def recursive_filter(node: TreeNode) -> Optional[TreeNode]:
        match node:
            case (_, _, []):
                return None
            case (line, title, [*subtree]):
                subtree = filter_tree(subtree)
                if subtree:
                    return line, title, subtree
                else:
                    return None
            case (int(), str()):
                return node

    new_tree = [recursive_filter(node) for node in tree]
    filtered_tree = list(filter(None, new_tree))

    return filtered_tree


def handle_file(link_pattern: re.Pattern, file: io.TextIOWrapper) -> None:
    title_pattern: re.Pattern[str] = re.compile(r"#+ ")
    tree: List[TreeNode] = []

    path = [tree]
    matching_title = False
    for number, line in enumerate(file, start=1):

        if "#" == line[0] and title_pattern.match(line):
            # Remove the levels in path that are on lower levels
            level = line.find(" ")
            del path[level:]

            nodes = path[-1]
            subtree = list()
            nodes.append((number, line[(level + 1):].rstrip(), subtree))
            path.append(subtree)

            matching_title = bool(link_pattern.match(line))

        elif matching_title or link_pattern.match(line):
            path[-1].append((number, line.rstrip()))

    tree = filter_tree(tree)
    if tree:
        filename = os.path.basename(file.name)
        filetitle = os.path.splitext(filename)[0]

        print("#", filename)

        match tree:
            case [(int(), title, [*subtree])] if title == filetitle:
                print_tree(subtree, level=1)

            case _:
                print_tree(tree, level=2)

        print()


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('search_term')
    parser.add_argument('filename', nargs="+")

    args = parser.parse_args(sys.argv[1:])

    # Since we want ignore case, re is faster than s in line
    link_pattern: re.Pattern[str] = re.compile(rf".*\[\[{args.search_term}\]\]", re.IGNORECASE)
    for filename in args.filename:
        with open(filename, "r") as file:
            handle_file(link_pattern, file)


if __name__ == "__main__":
    main()
