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
Accuracy:     0.6716
Macro-F1:     0.6002
Weighted-F1:  0.6675
```


## Week 2 (20260928 - 20261003)

### Focal loss

Due to the disproportionate class sizes of the dataset, I was advised to implement focal loss.
Indeed, this was helpful in training smaller categories (eg. disgust, fear), with the trade-off of a similar decrement in accuracy for larger categories.

Therefore, I personally believe implementing focal loss would not be particularly beneficial to this research.
The source code with focal loss implemented is saved in a branch and ready to be reused if needed.

```
Category Confusion Matrix (without focal loss)
          anger  disgust  fear   joy  sadness  surprise  neutral
anger       409       21     4    75       33        39      122
disgust      25       39     2     8        2         4        4
fear          6        3    57     4       11         4        5
joy          62        2    10  1772       17        32      159
sadness      32        4     2    39      176        25       39
surprise     42        5     3    95       22       331       75
neutral     227        9     8   297       56       148      861
```

```
Category Confusion Matrix (with focal loss)

          anger  disgust  fear   joy  sadness  surprise  neutral
anger       412       64    17    43       67        55       45
disgust      14       57     6     1        4         2        0
fear          3        5    70     1        9         1        1
joy         107       24    34  1543       84       117      145
sadness      33       15    16    16      207        18       12
surprise     34       10     7    42       24       417       39
neutral     304       42    58   231      112       257      602
```


### Meta-learning