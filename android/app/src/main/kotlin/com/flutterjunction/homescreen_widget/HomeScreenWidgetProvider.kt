package com.flutterjunction.homescreen_widget  // your package name

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeScreenWidgetProvider : HomeWidgetProvider() {
     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // Open App on Button Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                        MainActivity::class.java, Uri.parse("myapp://newscreen"))
                setOnClickPendingIntent(R.id.bt_navigate, pendingIntent)

                //Open App on widget click
                val newIntent = HomeWidgetLaunchIntent.getActivity(context,
                        MainActivity::class.java, Uri.parse("myapp://launchapp"))
                setOnClickPendingIntent(R.id.widget_root, newIntent)

                //shared preferences
                val counter = widgetData.getInt("_counter", 0)

                var counterText = "Your counter value is: $counter"

                if (counter == 0) {
                    counterText = "You have not pressed the counter button"
                }

                setTextViewText(R.id.tv_counter, counterText)

                // Pending intent to update counter on button click
                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                        Uri.parse("myapp://updateCounter"))
                setOnClickPendingIntent(R.id.bt_update, backgroundIntent)


            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}