package dao;

import model.Activity;
import util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ActivityDAO implements IActivityDAO {

    @Override
    public void addActivity(Activity activity) throws SQLException {
        if (activity.getUserId() <= 0) {
            throw new IllegalArgumentException("Invalid user_id for activity");
        }

        String query = "INSERT INTO activities (user_id, activity_name, day_of_week, start_time) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, activity.getUserId());
            stmt.setString(2, activity.getActivityName());
            stmt.setString(3, activity.getDayOfWeek());
            stmt.setString(4, activity.getStartTime());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
        } catch (SQLException e) {
            System.err.println("Error adding activity: " + e.getMessage());
            throw e;
        }
    }

    @Override
    public void deleteActivity(int activityId) throws SQLException {
        String query = "DELETE FROM activities WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, activityId);
            stmt.executeUpdate();
        }
    }

    @Override
    public void updateActivity(Activity activity) throws SQLException {
        String query = "UPDATE activities SET activity_name = ?, day_of_week = ?, start_time = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, activity.getActivityName());
            stmt.setString(2, activity.getDayOfWeek());
            stmt.setString(3, activity.getStartTime());
            stmt.setInt(4, activity.getId());
            stmt.executeUpdate();
        }
    }
    
    public List<Activity> getActivitiesByUserId(int userId) throws SQLException {
        List<Activity> activities = new ArrayList<>();
        String query = "SELECT * FROM activities WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Activity activity = new Activity(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("activity_name"),
                    rs.getString("day_of_week"),
                    rs.getString("start_time")
                );
                activities.add(activity);
            }
        } catch (SQLException e) {
            System.err.println("Error in getActivitiesByUserId: " + e.getMessage());
            throw e;
        }
        return activities;
    }
}
