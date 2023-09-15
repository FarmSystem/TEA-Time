import React, { Component, useState } from "react";
import { StyleSheet, ScrollView, Text, View, Image } from "react-native";
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

export const SettingPage = () => {
  return (
    <Container>
      <StyledText>SettingPage입니다.</StyledText>
    </Container>
  );
};
