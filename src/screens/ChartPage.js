import { BarChart, LineChart, PieChart } from "react-native-gifted-charts";

import React, { Component, useState } from "react";
import { StyleSheet, ScrollView, Text, View, Image } from "react-native";
import { Calendar, LocaleConfig } from "react-native-calendars";
import styled, { ThemeProvider } from "styled-components/native";
import RoundButton from "../components/RoundButton";
import Button from "../components/Button";
import { Filter } from "../components/Filter";
import Show from "../components/Show";
import { theme } from "../theme";
import { Task } from "../components/Task";
//let Icon = require('../assets/icons/search2.png');

// ...
const data = [{ value: 50 }, { value: 80 }, { value: 90 }, { value: 70 }];

export default function ChartPage() {
  return (
    <ScrollView>
      <Text>Chart List</Text>
      <BarChart data={data} />
      <LineChart data={data} />
      <PieChart data={data} />
      {/* // For Horizontal Bar chart, just add the prop horizontal to the{" "} */}
      <BarChart />
      <BarChart data={data} horizontal />
      {/* // For Area chart, just add the prop areaChart to the <LineChart />{" "}
      component */}
      <LineChart data={data} areaChart />
      {/* // For Donut chart, just add the prop donut to the <PieChart /> component */}
      <PieChart data={data} donut />
    </ScrollView>
  );
}
