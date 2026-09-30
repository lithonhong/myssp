## Week 1 (20260921 - 20260927)

Having no previous experience with NLP or PyTorch, much of this week was simply documentation-reading to get a brief view.
I chose to use XLM-RoBERTa-base as my tokenizer by virtue of its multilingual tokenising capability.

### Malay databases

I installed `melayu_ternate.csv` ([Link](https://www.kaggle.com/datasets/bangsate/emosi-melayu-ternate)) and ran a quick classification with XLM-RoBERTa.
I later found this dataset not a good fit for the purposes of this research as this dataset concerns Indonesian and Ternate Malay.

The results are rather disappointing: an accuracy of 0.4214, with the confusion matrix indicating that only three of the ten emotions were learnt.
The cause is believed to be the low sample size of certain emotions.

I believe EmoTweet-Malay-6 would have been useful, but it is not open-sourced.
If we truly find this beneficial, it might be worth reaching out to them.

I also found `emotion-twitter-lexicon.js` ([Link](https://github.com/rozabond/malay-dataset/tree/master/corpus/emotion)), but the dataset is too large for the purpose of this research.


### English databases (GoEmotions)

Initial attempts to train models using GoEmotions yield an accuracy of about 0.45.
This is due to the multi-label nature of its samples.
Using the Ekman mapping, I have classified the 27 emotions from GoEmotions into 7 main categories (+ neutral).
Training the single-label model shoots the accuracy up to 0.68.

The following table shows the number of samples for each emotion.
| emotion | train | test | valid | total |
| :--- | :---: | :---: | :---: | :---: |
| **joy** | 16948 | 2054 | 2169 | 21171 |
| **neutral** | 12823 | 1606 | 1592 | 16021 |
| **anger** | 5336 | 703 | 685 | 6724 |
| **surprise** | 4489 | 573 | 522 | 5584 |
| **sadness** | 2619 | 317 | 299 | 3235 |
| **fear** | 615 | 90 | 85 | 790 |
| **disgust** | 580 | 84 | 74 | 738 |
| **total** | **43410** | **5427** | **5426** |

Beyond this point, modifying the learning rate, batch size, or number of epoch cause little to no effect, and the model seems to overfit beyond Epoch 3.

```
Evaluation of base model
Accuracy:     0.6792
Macro-F1:     0.6032
Weighted-F1:  0.6743
```


## Week 2 (20260928 - 20261003)

### Focal loss

Due to the disproportionate class sizes of the dataset, I was advised to implement focal loss.
Indeed, this was helpful in training smaller categories (eg. disgust, fear), with the trade-off of a similar decrement in accuracy for larger categories.

Therefore, I personally believe implementing focal loss would not be particularly beneficial to this research.
The source code with focal loss implemented is saved in a branch and ready to be reused if needed.

```
Evaluation of model with focal loss
Accuracy:     0.6178
Macro-F1:     0.5442
Weighted-F1:  0.6212
```


```
Category Confusion Matrix (without focal loss)
          anger  disgust  fear   joy  sadness  surprise  neutral
anger       396       19     6    71       31        39      141
disgust      23       37     3     8        4         4        5
fear          7        3    59     3        8         3        7
joy          47        3    11  1787       16        36      154
sadness      30        3     3    39      168        24       50
surprise     31        3     4    93       21       336       85
neutral     181        8     7   306       44       157      903
```

```
Category Confusion Matrix (with focal loss)

          anger  disgust  fear   joy  sadness  surprise  neutral
anger       421       62    18    45       50        48       59
disgust      10       60     6     3        2         3        0
fear          4        5    70     0       10         0        1
joy         117       13    35  1557       76       102      154
sadness      37       16    14    15      200        17       18
surprise     35       10     7    43       23       407       48
neutral     311       42    45   230      104       236      638
```


### Meta-learning

TBC