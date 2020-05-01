from subjective_test.utilities import transform_mos


def test_basic_transform():
    m = [1.1, 4, 5, 2, 3, 1.2, 4]
    c = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]
    new_rank = transform_mos(m, c)
    expected =[1.5, 5.5, 7, 3, 4, 1.5, 5.5]
    assert (expected == new_rank).all(), print(new_rank)


def test_figure_3():
    # case a
    print('case a')
    mos = [4, 2]
    ci = [0.5, 0.5]
    expected_rank = [2, 1]
    t = transform_mos(mos, ci)
    assert (t== expected_rank).all(), print(t)

    # case b
    print('case b')
    mos = [4, 3]
    ci = [0.6, 0.6]
    expected_rank = [2, 1]
    t = transform_mos(mos, ci)
    assert (t == expected_rank).all(), print(t)

    #  case c
    print('case c')
    mos = [4, 3.5]
    ci = [0.6, 0.2]
    expected_rank = [1.5, 1.5]
    t = transform_mos(mos, ci)
    assert (t == expected_rank).all(), print(t)

    # case d
    print('case d')
    mos = [4, 3.8, 3.3]
    ci = [0.6, 0.6, 0.2]
    expected_rank = [2.5, 2.5, 1]
    t = transform_mos(mos, ci)
    assert (t == expected_rank).all(), print(t)

    #  case e
    print('case e')
    mos = [4, 3.5, 3.3]
    ci = [0.6, 0.3, 0.2]
    expected_rank = [3, 1.5, 1.5]
    t = transform_mos(mos, ci)
    assert (t == expected_rank).all(), print(t)

    #  case f
    print('case f')
    mos = [4, 3.5, 3.3]
    ci = [0.8, 0.4, 0.3]
    expected_rank = [2, 2, 2]
    t = transform_mos(mos, ci)
    assert (t == expected_rank).all(), print(t)


def test_final():
    mos = [4.49272507194938, 4.26577212950124, 4.10033767612383, 3.93832658710171, 3.93935656976414, 3.91288674666551,
           3.91261926134431, 3.84816451136751, 3.71592312027156, 3.74955202733778]
    ci = [0.0879, 0.0984, 0.1058, 0.095, 0.1016, 0.1027, 0.1095, 0.1165, 0.0973, 0.1236]
    expected_rank = [10, 9, 8, 5, 5, 5, 5, 5, 1.5, 1.5]
    t = transform_mos(mos, ci)
    assert (t == expected_rank).all(), print(t)


if __name__ == "__main__":
    test_basic_transform()
    test_figure_3()
    test_final()