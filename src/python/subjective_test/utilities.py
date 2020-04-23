
"""
/*---------------------------------------------------------------------------------------------
*  Copyright (c) Dr. Babak Naderi. All rights reserved.
*  Licensed under the MIT License. See License.txt in the project root for license information.
*--------------------------------------------------------------------------------------------*/
@author: Babak Naderi
"""

import pandas as pd
import numpy as np

def transform_mos(mos, ci):
    """
    TRANSFORM_MOS Transform the MOS values given 95% Condifence Intervals, so two similar MOS values get a same rank
    although their MOS values are not equivalent.
    :param mos:
    :param ci:
    :return:
    """
    if len(mos) != len(ci):
        raise ValueError("MOS and CI should have a same size")
    df = pd.DataFrame({'mos': mos, 'ci': ci})
    #df['org_ind'] = df.index
    df['mos_rank'] = df['mos'].rank()
    df = df.sort_values(by=['mos'])
    df.reset_index(inplace=True)

    new_ranks = [0] * len(mos)
    # first one get the rank 1
    new_ranks[0] = 1

    tied_set_mos = []
    tied_set_ci = []
    for i in range(1, len(mos)):
        # check if it make a tied rank with the previous item
        if is_tied_rank( df['mos'][i - 1], df['ci'][i - 1], df['mos'][i], df['ci'][i]):
            new_ranks[i] = new_ranks[i - 1]
            # now check if there is a set
            if len(tied_set_mos) == 0:
                # there is no set
                # make a set
                tied_set_mos = [df['mos'][i - 1], df['mos'][i]]
                tied_set_ci = [df['ci'][i - 1], df['ci'][i]]
            else:
                # a set already exist
                # add the new item to the set
                tied_set_mos = tied_set_mos + [df['mos'][i]]
                tied_set_ci = tied_set_ci + [df['ci'][i]]
                # check if the set is still valid
                if not is_tied_set_valid(tied_set_mos, tied_set_ci):
                    # correct the set
                    # add the last element of set to a new tmp set
                    tmp_mos = [tied_set_mos[-1]]
                    tmp_ci = [tied_set_ci[-1]]

                    new_ranks[i] = new_ranks[i-1] + 1
                    del tied_set_mos[-1]
                    del tied_set_ci[-1]
                    # %check if last element of set1 want to be in set2
                    while (len(tied_set_mos) > 1 and
                           abs(tmp_mos[0] - tied_set_mos[-1]) < abs(tied_set_mos[-2]-tied_set_mos[-1]) and
                           is_tied_set_valid([tied_set_mos[-1]]+ tmp_mos, [tied_set_ci[-1]]+ tmp_ci)):
                        tmp_mos = [tied_set_mos[-1]] + tmp_mos
                        tmp_ci = [tied_set_ci[-1]] + tmp_ci
                        del tied_set_mos[-1]
                        del tied_set_ci[-1]
                    # now everyone in the tmp_mos should get rank(i)
                    for j in range(len(tmp_mos)):
                        new_ranks[i-j] = new_ranks[i]
                    tied_set_mos = tmp_mos
                    tied_set_ci = tmp_ci
        else:
            new_ranks[i] = new_ranks[i - 1] + 1
            tied_set_mos = []
            tied_set_ci = []
    df['tmp_rank'] = new_ranks
    df['new_rank'] = df['tmp_rank'].rank()
    df = df.sort_values(by=['index'])
    df.reset_index(inplace=True)
    return df['new_rank']


def is_tied_rank(mos_a, ci_a, mos_b, ci_b):
    if round(mos_a, 2) >= round(mos_b - ci_b, 2) and round(mos_a, 2) <= round(mos_b + ci_b, 2):
        return True
    if round(mos_b, 2) >= round(mos_a - ci_a, 2) and round(mos_b, 2) <= round(mos_a + ci_a, 2):
        return True
    return False


def is_tied_set_valid(mos_set, ci_set):
    length = len(mos_set)
    for i in range(length-1, -1, -1):
        for j in range(i-1, -1, -1):
            if not is_tied_rank(mos_set[i], ci_set[i], mos_set[j], ci_set[j]):
                return False
    return True


if __name__ == '__main__':
    m = [10, 8, 5.5]
    c = [4, 3, 1]
    new_rank = transform_mos(m, c)
    print(new_rank)
