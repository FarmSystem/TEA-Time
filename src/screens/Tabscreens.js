import React, {Component} from 'react';
import {StyleSheet, ScrollView, Text, View, Image} from 'react-native';
import styled, {ThemeProvider} from 'styled-components/native';
import RoundButton from '../components/RoundButton';
import data from "../db/data.json";
import Button from '../components/Button';
import {Filter} from '../components/Filter';
import Show from '../components/Show';
import {theme} from '../theme';
import {Task} from '../components/Task';
//let Icon = require('../assets/icons/search2.png');


const Container = styled.View`
flex : 1;
justify-content : center;
align-items : center;
background-color : #FFF9F2;
`;

const StyledText = styled.Text`
font-size : 30px;
`;

const Backcolor = styled.TouchableOpacity`
width : 100px;
height : 50px;
margin : 3px 0;
padding : 15px 20px;
border-radius : 10px;
justify-content: space-around;
background-color : white;
color : ${({theme}) => theme.text};
`;

const styles = StyleSheet.create({
    container : {
        flex : 1,
        backgroundColor : '#FFF9F2',
        justifyContent : 'center',
    },
    word : {
        justifyContent : 'center',
        alignItems : 'center',
    },
    PlusButton : {
        justifyContent: 'space-between',
        alignItems : 'space-around',
        top : 40
    },
    image : {
      width : '80%',
      height : 300,
    },
    body : {
      color : '#37474f',
      fontSize : 16,
      lineHeight : 21,
    },
});


const Styledfilter = StyleSheet.create({
  filter : {
    justifyContent : 'space-between',
    alignItems : 'flex-end',
    top : -65
  }
})

const List = styled.ScrollView`
width : ${({width}) => width - 40}px;
`;

//const width = Dimensions.get('window').width;

const diary = StyleSheet.create({
    card: {
      flex: 1,
      backgroundColor: 'white',
      alignItems: 'center',
      justifyContent: 'center',
    },
    cardContainer : {
      elevation : 5,
      borderRadius : 5,
      borderWidth : 0.3,
      borderColor : '#FFF9F2',
      margin : 30,
      elevation : 5
  },
  cardImage : {
      width : '100%',
      alignItems : 'center',
      justifyContent: 'center',
  },
  cardTitle : {
    width: '100%',
    fontWeight: 'bold',
    fontSize: 20,
    padding: 3
  },
  cardText : {
    width: '100%',
    fontSize: 12,
    padding: 3
  },
  cardEmotions : {
    width : '100%',
    fontSize : 12,
    padding : 3
  }
  })
  
function Diarylist() {
    console.disableYellowBox = true;
  
    let tip = data.tip;
  
    return (
    <View style={diary.cardContainer}>
        {tip.map((content, i) => {
            return (
              <View style={diary.card} key={i}>
                <Image source = {Icon} style = {styles.image}/>
                <Image style={diary.cardImage} source={{ uri: content.image }} />
                <View style={diary.cardText}>
                  <Text style={diary.cardTitle} numberOfLines={1}>
                    {content.title}
                  </Text>
                  <Text style={diary.cardEmotions} numberOfLines={3}>
                    {content.emotions}
                  </Text>
                </View>
              </View>
            );
          })}
    </View>
    );
  };


export const Calendar = () => {
    return (
        <Container>
            <StyledText>Calendar</StyledText>   
        </Container>
    );
};


export class DiaryList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      clicked : true // 초기에는 Filter 컴포넌트를 렌더링하지 않도록 설정
    };
  }

  _FilterPress = () => {
    this.setState({clicked : false});

    console.log('Filter 버튼이 눌렸습니다.');
  };
    render(){
       const { showFilter } = this.state;
       return (
        <ThemeProvider theme = {theme}>
          <View style = {styles.container}>
             {/*<Diarylist/>*/}
             <View style = {Styledfilter.filter}>
               {
                 this.state.clicked
                   ? <Button title = "최신순" onPress = {() => alert('click!!')} />
                   : <Filter />
               }
             </View>
             {showFilter && <Filter />}
             {/*<List width = {width}>
              {data.tip.map(item => (<Task key = {item.id} text = {item.title}/>))}
             </List>*/}
                <View style = {styles.word}>
                  <Show title = "24일 일기 제목"/>
                  <Show title = "23일 일기 제목"/>
                  <Show title = "22일 일기 제목"/>
                  <Show title = "21일 일기 제목"/>
                </View>
             <View style = {styles.PlusButton}>
                 <RoundButton title = "+"/>
             </View>
          </View>
        </ThemeProvider>
     );
   }  
 }   

export const Chart = () => {
    return (
        <Container>
            <StyledText>Chart</StyledText>
        </Container>
    );
};

export const Settings = () => {
    return (
        <Container>
            <StyledText>Settings</StyledText>
        </Container>
    );
};