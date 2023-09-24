from emotion_model import EmotionAnalysis

Analysis = EmotionAnalysis()
    
with open("BERTmodel/model_test.txt") as text :
    text_test = text.readlines()
    text_test = "".join(text_test)
    
Analysis.analyze_emotion(text_test)

# 패딩 길이 조절 필요
# ValueError: 128 is not a valid PaddingStrategy, please select one of ['longest', 'max_length', 'do_not_pad']