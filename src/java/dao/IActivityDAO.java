/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author ASUS
 */

import model.Activity;
import java.sql.SQLException;
import java.util.List;

public interface IActivityDAO {

    public void addActivity(Activity activity) throws SQLException;

    public void deleteActivity(int activityId) throws SQLException;

    public void updateActivity(Activity activity) throws SQLException;
}
