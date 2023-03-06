from Tree import Tree

# write the text file in a string
# line by line.
file = open("HarryPotter.txt", "r")
text_file = ""
for line in file:
    text_file += line[:-1] + " "
    # :-1 is to remove the line break

# order corresponds to the amount of characters that influence the next character.
# the higher this number, the bigger the training data should be.
order = 4

# tree contains a branch for each character. each branch itself
# has branches too, and this repeats for <order> times.
# And the branches extremity, there are the leaves. Those
# correspond to the characters that can be outputted for each
# possible chain of character.
tree = Tree()

#############################################
# Training
#############################################

for index in range(0, len(text_file) - order - 1):
    # ngram is a chain of character that is <order> long.
    ngram = text_file[index:index + order]
    # following_letter is the letter that follows the ngram.
    following_letter = text_file[index + order]

    # we now find (or create) the branches / sub-branches /sub-sub-branches/ etc... until we reached the path
    # that corresponds to ngram. For example, let's take "ling" as ngram. the first branch will be "l" then, the sub
    # branch will be the branch coming out of the branch "l" going to "i" etc.
    # At the last branch "l" -> "i" -> "n" -> "g" we add a leaf that would (probably) following_letter.
    branch = tree.find_branch(ngram[0])[0]
    for c in ngram[1:]:
        # recursively find the branch of the next character
        branch = branch.find_branch(c)[0]
    # its obvious now
    branch.add_leaf(following_letter)

#############################################
# generating the text
#############################################

# the initialisation of this field can lead to an error of this sequence of letter never comes in the whole text.
# highly recommended to use a word that is in the text. Definitely not something like "qkttvf"
generated_text = "greetings sir my name is"

# depends on how much text you want to generate
for i in range(0, 5000):
    # last <order> letters of the generated_text
    last_gram = generated_text[len(generated_text) - order:]

    # This finds the path of this specific chain of characters (recursive method)
    # find_branch returns tuples of type (Tree, char), so we only keep the Tree part. (origin of [0] at the end
    branch = tree.find_branch(last_gram[0])[0]
    for c in last_gram[1:]:
        branch = branch.find_branch(c)[0]

    # pick a random leaf of this branch extremity and add it to the generated_text
    # the more leaves you put of a certain character, the higher the chance is to pick that leaf.
    # In the case of the aforementioned example "ling". The chance that the next character is a " " (in english) is
    # very high. The number of leafs that have the value " " on it is proportional to the chance it is to
    # come up after this chain of character in the text.
    generated_text += branch.random_leaf()

print(generated_text)
