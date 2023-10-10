import React from "react";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { DiaryList, Chart, Settings } from "../screens/Tabscreens";
import { MaterialCommunityIcons } from "@expo/vector-icons";
import { StyleSheet, TouchableOpacity, Text, View } from "react-native";
//import IconButton from '../components/IconButton';

// 페이지 컴포넌트화를 위해 탭 별로 페이지 만들어 분리하기
import { CalendarPage } from "../screens/CalendarPage";
import { SettingPage } from "../screens/SettingPage";
import WritePage from "../screens/WritePage";
import ChartPage from "../screens/ChartPage";
import Mypage from "../screens/Mypage";

const TabIcon = ({ name, size, color }) => {
  return <MaterialCommunityIcons name={name} size={size} color={color} />;
};

const Tab = createBottomTabNavigator();

const styles = StyleSheet.create({
  Container: {
    backgroundColor: "white",
    justifyContent: "space-between",
    alignItems: "flex-end",
    top: 30,
  },
});

export const TabNavigation = () => {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarStyle: { backgroundColor: "#F4E8D1" },
      })}
    >
      <Tab.Screen
        name="Calendar"
        component={CalendarPage}
        options={{
          headerStyle: { backgroundColor: "#F4E8D1" },
          fontWeight: "bold",
          tabBarIcon: (props) => TabIcon({ ...props, name: "calendar" }),
        }}
      />

      <Tab.Screen
        name="DiaryList"
        component={DiaryList}
        options={{
          headerStyle: { backgroundColor: "#F4E8D1" },
          fontWeight: "bold",
          tabBarIcon: (props) =>
            TabIcon({ ...props, name: "file-document-outline" }),
        }}
      />

      <Tab.Screen
        name="감정 분석 차트"
        component={ChartPage}
        options={{
          headerStyle: { backgroundColor: "#F4E8D1" },
          fontWeight: "bold",
          // tabBarIcon: (props) => TabIcon({ ...props, name: "chart-bar" }),
        }}
      />

      {/*<Tab.Screen
        name="Settings"
        component={SettingPage}
        options={{
          headerStyle: { backgroundColor: "#F4E8D1" },
          fontWeight: "bold",
          tabBarIcon: (props) => TabIcon({ ...props, name: "account-cog" }),
        }}
      />*/}

      <Tab.Screen
        //name="DiaryWrite"
        name = "Mypage"
        //component={WritePage}
        component = {Mypage}
        options={{
          headerStyle: { backgroundColor: "#F4E8D1" },
          fontWeight: "bold",
          tabBarIcon: (props) => TabIcon({ ...props, name: "account-cog" }),
        }}
      />
    </Tab.Navigator>
  );
};
