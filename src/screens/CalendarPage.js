import React, { Component, useState } from "react";
import { StyleSheet, ScrollView, Text, View, Image } from "react-native";
import { Calendar, LocaleConfig } from "react-native-calendars";
import styled, { ThemeProvider } from "styled-components/native";
import RoundButton from "../components/RoundButton";
import data from "../db/data.json";
import Button from "../components/Button";
import { Filter } from "../components/Filter";
import Show from "../components/Show";
import { theme } from "../theme";
import { Task } from "../components/Task";
//let Icon = require('../assets/icons/search2.png');

const Container = styled.View`
  flex: 1;
  justify-content: center;
  align-items: center;
  background-color: #fff9f2;
`;

const StyledText = styled.Text`
  font-size: 30px;
`;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#FFF9F2",
    justifyContent: "center",
  },
  word: {
    justifyContent: "center",
    alignItems: "center",
  },
  PlusButton: {
    position: "absolute",
    top: 580,
    right: 100,
    left: 300,
  },
  image: {
    width: "80%",
    height: 300,
  },
  body: {
    color: "#37474f",
    fontSize: 16,
    lineHeight: 21,
  },
  emotionContainer: {
    display: "flex",
    // width: "100%",
    flex: 0.3,
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    width: 200,
  },
  emotionFlexBox: {
    // flex: 1,
    flexDirection: "row",
    width: 55,
  },
  emoBox: {
    width: 25,
    height: 25,
  },
});

export const CalendarPage = () => {
  const [selectedDate, setSelectedDate] = useState(null);

  // 선택한 날짜를 "yyyymmdd" 형식으로 변환하는 함수
  const formatSelectedDate = (dateString) => {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const day = String(date.getDate()).padStart(2, "0");
    return `${year}${month}${day}`;
  };

  return (
    <Container
      style={{
        display: "flex",
        flexDirection: "column",
        justifyContent: "flex-start",
      }}
    >
      <Calendar
        style={{
          borderWidth: 1,
          borderColor: "gray",
          height: 350,
          width: 375,
        }}
        theme={{
          backgroundColor: "#ffffff",
          calendarBackground: "#ffffff",
          textSectionTitleColor: "#b6c1cd",
          todayTextColor: "#00adf5",
          dayTextColor: "#2d4150",
          textDisabledColor: "#9E9E9E",
        }}
        onDayPress={(day) => {
          setSelectedDate(day.dateString); // 선택한 날짜 저장
        }}
        enableSwipeMonths={true}
        markingType="custom"
        markedDates={{
          [selectedDate]: {
            customStyles: {
              container: {
                backgroundColor: "orange", // 선택한 날짜의 배경색을 변경
              },
              text: {
                color: "white", // 선택한 날짜의 텍스트 색상을 변경
              },
            },
          },
        }}
      />
      <View style={styles.emotionContainer}>
        {/* 선택한 날짜를 표시 */}
        <Text style={{ fontSize: 20 }}>
          {selectedDate ? formatSelectedDate(selectedDate) : ""}
        </Text>
        <View style={styles.emotionFlexBox}>
          <View style={[styles.emoBox, { backgroundColor: "green" }]} />
          <Text style={{ fontSize: 20 }}>Good</Text>
        </View>
        <View style={styles.emotionFlexBox}>
          <View style={[styles.emoBox, { backgroundColor: "red" }]} />
          <Text style={{ fontSize: 20 }}>Bad</Text>
        </View>
      </View>
      <View>
        <Show title="24일 일기 제목입니다." />
      </View>
    </Container>
  );
};
