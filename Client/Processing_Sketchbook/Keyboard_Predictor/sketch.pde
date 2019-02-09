/****************************************************/
// ================================================ //
/****************************************************/
/*
 * Import libraries
 */
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

/****************************************************/
// ================================================ //
/****************************************************/
/*
 * Global Variables
 */
Context context;
SensorManager manager;
Sensor sensor;
AccelerometerListener listener;

float ax, ay, az;
boolean keyboard = false;

/****************************************************/
// ================================================ //
/****************************************************/
/*
 * Setup method
 */
void setup() {
	fullScreen();
	textFont(createFont("SansSerif", 40 * displayDensity));
	fill(0);

	context = getActivity();
	manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
	sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
	listener = new AccelerometerListener();
	manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
}

/****************************************************/
// ================================================ //
/****************************************************/
/*
 * Draw method
 */
void draw() {
	background(255);
//	text(key, width/2, height/2);
	text("X: " + ax + "\nY: " + ay + "\nZ: " + az, 0, 0, width, height);
}

/****************************************************/
// ================================================ //
/****************************************************/
/*
 * Custom Classes
 */
class AccelerometerListener implements SensorEventListener {
	public void onSensorChanged(SensorEvent event) {
		ax = event.values[0];
		ay = event.values[1];
		az = event.values[2];
	}
	public void onAccuracyChanged(Sensor sensor, int accuracy) {
	}
}

/****************************************************/
// ================================================ //
/****************************************************/
/*
 * Interrupt Event Driven Methods
 */
void keyPressed() {
	background(200, 50, 30);  
}

void mousePressed() {
	if (!keyboard) {
		openKeyboard();
		keyboard = true;
	} else {
		closeKeyboard();
		keyboard = false;
	}
}

public void onResume() {
	super.onResume();
	if (manager != null) {
		manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
	}
}

public void onPause() {
	super.onPause();
	if (manager != null) {
		manager.unregisterListener(listener);
	}
}

/****************************************************/
// ================================================ //
/****************************************************/
