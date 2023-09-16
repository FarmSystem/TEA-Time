import React, { useState } from "react";
import {
  StyleSheet,
  Switch,
  FlatList,
  Platform,
  TouchableOpacity,
  View,
} from "react-native";
import { Block, Text, theme, Icon } from "galio-framework";

import materialTheme from "../constants/Theme";

export const SettingPage = () => {
  const [selectedDate, setSelectedDate] = useState(null);
  const [switchStates, setSwitchStates] = useState({});

  const toggleSwitch = (switchNumber) => {
    setSwitchStates((prevSwitchStates) => ({
      ...prevSwitchStates,
      [switchNumber]: !prevSwitchStates[switchNumber],
    }));
  };

  const renderItem = ({ item }) => {
    switch (item.type) {
      case "switch":
        return (
          <Block row middle space="between" style={styles.rows}>
            <Text size={14}>{item.title}</Text>
            <Switch
              onValueChange={() => toggleSwitch(item.id)}
              ios_backgroundColor={materialTheme.COLORS.SWITCH_OFF}
              thumbColor={
                Platform.OS === "android"
                  ? materialTheme.COLORS.SWITCH_OFF
                  : null
              }
              trackColor={{
                false: materialTheme.COLORS.SWITCH_OFF,
                true: materialTheme.COLORS.SWITCH_ON,
              }}
              value={switchStates[item.id] || false} // 스위치 상태를 사용
            />
          </Block>
        );
      case "button":
        return (
          <Block style={styles.rows}>
            <TouchableOpacity onPress={() => navigate("Pro")}>
              <Block row middle space="between" style={{ paddingTop: 7 }}>
                <Text size={14}>{item.title}</Text>
                <Icon
                  name="angle-right"
                  family="font-awesome"
                  style={{ paddingRight: 5 }}
                />
              </Block>
            </TouchableOpacity>
          </Block>
        );
      default:
        break;
    }
  };

  // 현재는 사용 안하는 데이터더미들
  const recommended = [
    { title: "Use FaceID to sign in", id: "face", type: "switch" },
    { title: "Auto-Lock security", id: "autolock", type: "switch" },
    { title: "Notifications", id: "Notifications", type: "button" },
  ];

  const payment = [
    { title: "Manage Payment Options", id: "Payment", type: "button" },
    { title: "Manage Gift Cards", id: "gift", type: "button" },
  ];

  const privacy = [
    { title: "이용약관", id: "TermsOfUse", type: "button" },
    { title: "개인정보처리방침", id: "privacyPolicy", type: "button" },
    { title: "개발/관리자 정보", id: "developers", type: "button" },
  ];

  const generalSettings = [
    { title: "프로필", id: "profile", type: "button" },
    { title: "다크모드", id: "darkmode", type: "switch" },
    { title: "로그아웃", id: "signOut", type: "button" },
  ];

  return (
    <View
      showsVerticalScrollIndicator={false}
      contentContainerStyle={styles.settings}
    >
      <FlatList
        data={generalSettings}
        keyExtractor={(item, index) => item.id}
        renderItem={renderItem}
        ListHeaderComponent={
          <Block style={styles.title}>
            <Text
              bold
              center
              size={theme.SIZES.BASE}
              style={{ paddingBottom: 5 }}
            >
              일반 설정
            </Text>
            <Text center muted size={12}>
              기본 설정 리스트입니다.
            </Text>
          </Block>
        }
      />

      <Block style={styles.title}>
        <Text bold center size={theme.SIZES.BASE} style={{ paddingBottom: 5 }}>
          개인정보 보호 설정
        </Text>
        <Text center muted size={12}>
          정보 관련 규제 설정입니다.
        </Text>
      </Block>
      <FlatList
        data={privacy}
        keyExtractor={(item, index) => item.id}
        renderItem={renderItem}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  settings: {
    paddingVertical: theme.SIZES.BASE / 3,
  },
  title: {
    paddingTop: theme.SIZES.BASE,
    paddingBottom: theme.SIZES.BASE / 2,
  },
  rows: {
    height: theme.SIZES.BASE * 2,
    paddingHorizontal: theme.SIZES.BASE,
    marginBottom: theme.SIZES.BASE / 2,
  },
});
