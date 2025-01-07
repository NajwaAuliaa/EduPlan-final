package model;

import java.util.ArrayList;
import java.util.List;

public class ListTopic {
    private String topicName;
    private int duration;
    private boolean isChecked;
    private boolean isCompleted;

    private static final List<ListTopic> allTopics = new ArrayList<>();

    public ListTopic(String activityName, int duration) {
        this.topicName = activityName;
        this.duration = duration;
        this.isChecked = false;
        this.isCompleted = false;
    }

    public String getTopicName() {
        return topicName;
    }

    public void setTopicName(String topicName) {
        this.topicName = topicName;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public boolean isChecked() {
        return isChecked;
    }

    public void setChecked(boolean checked) {
        isChecked = checked;
    }

    public boolean isCompleted() {
        return isCompleted;
    }

    public void setCompleted(boolean completed) {
        isCompleted = completed;
    }

    public static List<ListTopic> getAllTopics() {
        return allTopics;
    }

    public static void addTopic(String name, int duration) {
        allTopics.add(new ListTopic(name, duration));
    }

    public static List<ListTopic> getCheckedTopics() {
        List<ListTopic> checkedTopics = new ArrayList<>();
        for (ListTopic topic : allTopics) {
            if (topic.isChecked()) {
                checkedTopics.add(topic);
            }
        }
        return checkedTopics;
    }
}
