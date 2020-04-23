# MOS-transformation
Implementation of MOS-transformation to be used with Rank based statistical techniques.

The rank correlation coefficients and the ranked-based statistical tests (as a subset of non-parametric techniques) might 
be misleading when they are applied to subjectively collected opinion scores. Those techniques assume that the data is 
measured at least at an ordinal level and define a sequence of scores to represent a tied rank when they have precisely 
an equal numeric value.

In this paper, we show that the definition of tied rank, as mentioned above, is not suitable for Mean Opinion Scores 
(MOS) and might be misleading conclusions of rank-based statistical techniques. Furthermore, we introduce a method to 
overcome this issue by transforming the MOS values considering their 95% Confidence Intervals. The rank correlation 
coefficients and ranked-based statistical tests can then be safely applied to the transformed values. We also provide 
open-source software packages in different programming languages to utilize the application of our transformation method 
in the quality of experience domain.

## Code
We provide implementation of our transformation method for MATLAB, Python and R.

### MARLAB
Add the directory `src/MATLAB` to your MATLAB search path.
``` MATLAB
mos = [10, 7];
ci = [4, 2];
expected_rank = [1.5,1.5];
new_rank = transform_mos(mos,ci); 
```

### Python
Installation
``` bash
pip install subjective-test
```
Input the corresponding function and use it:

``` python
    from subjective_test.utilities import transform_mos
    
    mos = [10, 6, 5.5]
    ci = [4, 2, 0.2]
    t = transform_mos(mos, ci)
    #  expected_rank = [3, 1.5, 1.5]
```

## Contact

Babak Naderi, babak.naderi[at]tu-berlin.de

## Citation
Naderi B, Möller S. [Transformation of Mean Opinion Scores to AvoidMisleading of Ranked based Statistical Techniques](https://arxiv) 
2020 Twelfth International Workshop on Quality of Multimedia Experience (QoMEX). IEEE, 2020.


## License
MIT License

Copyright 2020 (c) Dr. Babak Naderi.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.