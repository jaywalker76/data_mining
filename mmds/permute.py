""" This implements the exercises of minhash part for book: 'Mining the 
massive dataset(v1.3)'."""


hash_funcs = [lambda x: (2*x+1)%6, lambda x: (3*x+2)%6,
              lambda x: (5*x+2)%6]


def b(hash_funcs):
    """Which of these hash functions are true permutations?"""
    for hf in hash_funcs:
        res = []
        for i in xrange(6):
            res.append(str(hf(i)))
        print ','.join(res)


b(hash_funcs)
