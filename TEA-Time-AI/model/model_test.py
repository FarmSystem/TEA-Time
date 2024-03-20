from emotion_model import EmotionAnalysis

Analysis = EmotionAnalysis()

with open("model/data/model_test.txt") as text :
    text_test = text.readlines()
    text_test = "".join(text_test)
    
Analysis.analyze_emotion(text_test)