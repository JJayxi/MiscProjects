from random import randint


class Tree:
    def __init__(self):
        # contains every sub-branch. those can be leaves too. In python, we don't need to initialize to a specific
        # type
        # when saving sub-branches (not leaves), it saves tuples of type (Tree, char)
        self.branches = []

    def find_branch(self, char):
        # Checking each branch in the array branches to see if there is a branch labeled <char>
        for branch in self.branches:
            # branch is a tuple, so we need to look if the label corresponds to the character.
            if branch[1] == char:
                # We return the whole tuple (because it doesn't work otherwise. Question needed)
                return branch

        # if this branch doesn't exist yet, we grow it
        return self.add_branch(char)

    def add_branch(self, char):
        # add a tuple to the branches array with the correspond label
        self.branches.append((Tree(), char))
        # for simplifications reasons, we return the branch that we just added
        return self.branches[len(self.branches) - 1]

    def add_leaf(self, leaf):
        # adds a leaf (type char) in the branches array.This function is only called for the branches at the extremities
        self.branches.append(leaf)

    def random_leaf(self):
        # gives us a random leaf.
        return self.branches[randint(0, len(self.branches) - 1)]
