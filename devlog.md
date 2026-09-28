## 23 Sept 2026

I installed `melayu_ternate.csv` ([Link](https://www.kaggle.com/datasets/bangsate/emosi-melayu-ternate)) and ran a quick classification with XLM-RoBERTa.
I later found this dataset not a good fit for the purposes of this research as this dataset concerns Indonesian and Ternate Malay.

The results are rather disappointing: an accuracy of 0.4214, with the confusion matrix indicating that only three of the ten emotions were learnt.
The cause is believed to be the low sample size of certain emotions.


## 24 Sept 2026

I believe EmoTweet-Malay-6 would have been useful, but it is not open-sourced.
If we truly find this beneficial, it might be worth reaching out to them.

I also found `emotion-twitter-lexicon.js` ([Link](https://github.com/rozabond/malay-dataset/tree/master/corpus/emotion)), but the dataset is too large for the purpose of this research.

```
Number of examples: 160025

Class distribution:
Emotion
anger       85092
happy       25212
love        15071
fear        14213
sadness     11916
surprise     8521
Name: count, dtype: int64
```

I also attempted to run the GoEmotion database, however, the accuracy also floats around 0.45.


## 25 Sept 2026

I attempted to increase the accuracy by increasing the number of epoch, but found out that the model overfits beyond Epoch 3.


## 26 Sept 2026

Using the Ekman mapping, I have classified the 27 emotions from GoEmotions into 7 main categories (+ neutral).
Training the single-label model shoots the accuracy up to 0.68.
Modifying the learning rate, batch size, or number of epoch cause little to no effect.


## 28 Sept 2026

Second group meeting.

I was told that the disproportionate class size might be remedied with focal loss and/or triplet learning.
I was also suggested to go in the direction of meta-learning with prototype networks for this week.