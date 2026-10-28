package BuckConverter
  model buck
    parameter Modelica.Units.SI.Capacitance C(displayUnit = "uF") = 250e-6;
    parameter Modelica.Units.SI.Inductance L(displayUnit = "mH") = 120e-3;
    parameter Real R_L = 0.00001 "Inductor series resistance losses (Ohm)";
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(transformation(origin = {-86, -72}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = C) annotation(
      Placement(transformation(origin = {34, -32}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = L) annotation(
      Placement(transformation(origin = {-32, -2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor icoil annotation(
      Placement(transformation(origin = {20, -2}, extent = {{-10, 10}, {10, -10}})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor i_out annotation(
      Placement(transformation(origin = {64, -2}, extent = {{-10, 10}, {10, -10}})));
    Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
      Placement(transformation(origin = {-46, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
      Placement(transformation(origin = {-76, -2}, extent = {{-10, 10}, {10, -10}})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor i_in annotation(
      Placement(transformation(origin = {-106, -2}, extent = {{-10, 10}, {10, -10}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = R_L) annotation(
      Placement(transformation(origin = {-6, -2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput u annotation(
      Placement(transformation(origin = {-76, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealOutput y_i_in annotation(
      Placement(transformation(origin = {-88, 22}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-74, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealOutput y_i_coil annotation(
      Placement(transformation(origin = {38, 22}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealOutput y_i_out annotation(
      Placement(transformation(origin = {82, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {82, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Interfaces.PositivePin buck_input annotation(
      Placement(transformation(origin = {-136, -2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin buck_gnd_2 annotation(
      Placement(transformation(origin = {112, -62}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin buck_out annotation(
      Placement(transformation(origin = {112, -2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin buck_gnd_1 annotation(
      Placement(transformation(origin = {-130, -62}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, -70}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(i_in.n, switch.p) annotation(
      Line(points = {{-96, -2}, {-86, -2}}, color = {0, 0, 255}));
    connect(switch.n, inductor.p) annotation(
      Line(points = {{-66, -2}, {-42, -2}}, color = {0, 0, 255}));
    connect(icoil.n, i_out.p) annotation(
      Line(points = {{30, -2}, {54, -2}}, color = {0, 0, 255}));
    connect(diode.n, inductor.p) annotation(
      Line(points = {{-46, -22}, {-46, -2}, {-42, -2}}, color = {0, 0, 255}));
    connect(capacitor.p, icoil.n) annotation(
      Line(points = {{34, -22}, {34, -2}, {30, -2}}, color = {0, 0, 255}));
    connect(diode.p, ground.p) annotation(
      Line(points = {{-46, -42}, {-46, -62}, {-86, -62}}, color = {0, 0, 255}));
    connect(capacitor.n, ground.p) annotation(
      Line(points = {{34, -42}, {34, -62}, {-86, -62}}, color = {0, 0, 255}));
    connect(inductor.n, resistor1.p) annotation(
      Line(points = {{-22, -2}, {-16, -2}}, color = {0, 0, 255}));
    connect(resistor1.n, icoil.p) annotation(
      Line(points = {{4, -2}, {10, -2}}, color = {0, 0, 255}));
    connect(switch.control, u) annotation(
      Line(points = {{-76, -14}, {-76, -44}}, color = {255, 0, 255}));
    connect(i_out.i, y_i_out) annotation(
      Line(points = {{64, 9}, {64, 19}, {82, 19}}, color = {0, 0, 127}));
    connect(icoil.i, y_i_coil) annotation(
      Line(points = {{20, 9}, {20, 21}, {38, 21}}, color = {0, 0, 127}));
    connect(buck_input, i_in.p) annotation(
      Line(points = {{-136, -2}, {-116, -2}}, color = {0, 0, 255}));
    connect(ground.p, buck_gnd_2) annotation(
      Line(points = {{-86, -62}, {112, -62}}, color = {0, 0, 255}));
    connect(i_out.n, buck_out) annotation(
      Line(points = {{74, -2}, {112, -2}}, color = {0, 0, 255}));
    connect(ground.p, buck_gnd_1) annotation(
      Line(points = {{-86, -62}, {-130, -62}}, color = {0, 0, 255}));
    connect(i_in.i, y_i_in) annotation(
      Line(points = {{-106, 10}, {-106, 22}, {-88, 22}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-160, 40}, {140, -80}}), graphics),
      version = "",
      uses(Modelica(version = "4.1.0")),
      Icon(graphics = {Text(origin = {-35, -80}, extent = {{-63, 20}, {63, -20}}, textString = "Buck"), Line(points = {{-100, -100}, {100, 100}, {100, 100}}, thickness = 1.5), Rectangle(lineThickness = 1.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-40, 50}, extent = {{-40, 30}, {40, -30}}, textString = "DC"), Text(origin = {40, -50}, extent = {{-40, 30}, {40, -30}}, textString = "DC"), Text(origin = {0, 8}, textColor = {0, 0, 255}, extent = {{-150, 148}, {150, 108}}, textString = "%name")}));
  end buck;

  model control_PI
    parameter Real Ti = 1 "Time Constant (Ti>0 required)";
    parameter Real Kp = 1 "Proportional gain";
    parameter Modelica.Units.SI.Frequency frequency = 10000 "Switching frequency";
    parameter Modelica.Units.SI.Time period = 1/frequency;
    parameter Real setpoint = 1 "Setpoint of the controler";
    Modelica.Blocks.Interfaces.RealInput measure annotation(
      Placement(transformation(origin = {-140, -40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
    Modelica.Blocks.Continuous.PI PI(T = Ti, k = Kp) annotation(
      Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.SawTooth sawTooth(period = period) annotation(
      Placement(transformation(origin = {-10, -50}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.Greater greater annotation(
      Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput control_output annotation(
      Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Constant const(k = setpoint) annotation(
      Placement(transformation(origin = {-132, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Feedback feedback annotation(
      Placement(transformation(origin = {-94, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0) annotation(
      Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(sawTooth.y, greater.u2) annotation(
      Line(points = {{2, -50}, {12, -50}, {12, -8}, {28, -8}}, color = {0, 0, 127}));
    connect(greater.y, control_output) annotation(
      Line(points = {{52, 0}, {90, 0}}, color = {255, 0, 255}));
    connect(measure, feedback.u2) annotation(
      Line(points = {{-140, -40}, {-94, -40}, {-94, -8}}, color = {0, 0, 127}));
    connect(const.y, feedback.u1) annotation(
      Line(points = {{-121, 0}, {-103, 0}}, color = {0, 0, 127}));
    connect(feedback.y, PI.u) annotation(
      Line(points = {{-85, 0}, {-63, 0}}, color = {0, 0, 127}));
    connect(PI.y, limiter.u) annotation(
      Line(points = {{-38, 0}, {-22, 0}}, color = {0, 0, 127}));
    connect(limiter.y, greater.u1) annotation(
      Line(points = {{2, 0}, {28, 0}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "4.1.0")),
      Icon(graphics = {Rectangle(lineColor = {255, 0, 255}, lineThickness = 3, extent = {{-100, 100}, {100, -100}}), Text(textColor = {255, 0, 255}, extent = {{-100, 100}, {100, -100}}, textString = "PI"), Text(origin = {0, -8}, textColor = {0, 0, 255}, extent = {{-150, 148}, {150, 108}}, textString = "%name")}),
      Diagram(graphics));
  end control_PI;

  model control_antiwindup_P
    parameter Real Kp = 1 "Proportional gain";
    parameter Modelica.Units.SI.Frequency frequency = 10000 "Switching frequency";
    parameter Modelica.Units.SI.Time period = 1/frequency;
    parameter Real setpoint = 1 "Setpoint of the controler";
    Modelica.Blocks.Interfaces.RealInput measure annotation(
      Placement(transformation(origin = {-84, -30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
    Modelica.Blocks.Sources.SawTooth sawTooth(period = period) annotation(
      Placement(transformation(origin = {-10, -50}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.Greater greater annotation(
      Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput control_output annotation(
      Placement(transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Constant const(k = setpoint) annotation(
      Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.LimPID PID(k = Kp, yMax = 1, yMin = 0, controllerType = Modelica.Blocks.Types.SimpleController.P, y_start = 0.6) annotation(
      Placement(transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(sawTooth.y, greater.u2) annotation(
      Line(points = {{2, -50}, {12, -50}, {12, -8}, {28, -8}}, color = {0, 0, 127}));
    connect(greater.y, control_output) annotation(
      Line(points = {{52, 0}, {76, 0}}, color = {255, 0, 255}));
    connect(PID.y, greater.u1) annotation(
      Line(points = {{-5, 0}, {28, 0}}, color = {0, 0, 127}));
    connect(PID.u_m, measure) annotation(
      Line(points = {{-16, -12}, {-16, -30}, {-84, -30}}, color = {0, 0, 127}));
    connect(const.y, PID.u_s) annotation(
      Line(points = {{-39, 0}, {-28, 0}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "4.1.0")),
      Icon(graphics = {Rectangle(lineColor = {255, 0, 255}, lineThickness = 3, extent = {{-100, 100}, {100, -100}}), Text(textColor = {255, 0, 255}, extent = {{-100, 100}, {100, -100}}, textString = "P"), Text(origin = {0, -8}, textColor = {0, 0, 255}, extent = {{-150, 148}, {150, 108}}, textString = "%name")}),
      Diagram(graphics),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
  end control_antiwindup_P;

  model control_antiwindup_PI
    parameter Real Ti = 1 "Time Constant (Ti>0 required)";
    parameter Real Kp = 1 "Proportional gain";
    parameter Modelica.Units.SI.Frequency frequency = 10000 "Switching frequency";
    parameter Modelica.Units.SI.Time period = 1/frequency;
    parameter Real setpoint = 1 "Setpoint of the controler";
    Modelica.Blocks.Interfaces.RealInput measure annotation(
      Placement(transformation(origin = {-100, -30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
    Modelica.Blocks.Sources.SawTooth sawTooth(period = period) annotation(
      Placement(transformation(origin = {-10, -50}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.Greater greater annotation(
      Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput control_output annotation(
      Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Constant const(k = setpoint) annotation(
      Placement(transformation(origin = {-66, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.LimPID PID(k = Kp, Ti = Ti, yMax = 1, yMin = 0, controllerType = Modelica.Blocks.Types.SimpleController.PI, y_start = 0.6) annotation(
      Placement(transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(sawTooth.y, greater.u2) annotation(
      Line(points = {{2, -50}, {12, -50}, {12, -8}, {28, -8}}, color = {0, 0, 127}));
    connect(greater.y, control_output) annotation(
      Line(points = {{52, 0}, {90, 0}}, color = {255, 0, 255}));
    connect(PID.y, greater.u1) annotation(
      Line(points = {{-5, 0}, {28, 0}}, color = {0, 0, 127}));
    connect(PID.u_m, measure) annotation(
      Line(points = {{-16, -12}, {-16, -30}, {-100, -30}}, color = {0, 0, 127}));
    connect(const.y, PID.u_s) annotation(
      Line(points = {{-55, 0}, {-28, 0}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "4.1.0")),
      Icon(graphics = {Rectangle(lineColor = {255, 0, 255}, lineThickness = 3, extent = {{-100, 100}, {100, -100}}), Text(textColor = {255, 0, 255}, extent = {{-100, 100}, {100, -100}}, textString = "PI*"), Text(origin = {0, -8}, textColor = {0, 0, 255}, extent = {{-150, 148}, {150, 108}}, textString = "%name")}),
      Diagram(graphics),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
  end control_antiwindup_PI;

  model control_antiwindup_PI_SPchange
    parameter Real Ti = 1 "Time Constant (Ti>0 required)";
    parameter Real Kp = 1 "Proportional gain";
    parameter Modelica.Units.SI.Frequency frequency = 10000 "Switching frequency";
    parameter Modelica.Units.SI.Time period = 1/frequency;
    parameter Real setpoint = 1 "Setpoint of the controler";
    Modelica.Blocks.Interfaces.RealInput measure annotation(
      Placement(transformation(origin = {-100, -30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
    Modelica.Blocks.Sources.SawTooth sawTooth(period = period) annotation(
      Placement(transformation(origin = {-10, -50}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.Greater greater annotation(
      Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput control_output annotation(
      Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Constant const(k = setpoint) annotation(
      Placement(transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.LimPID PID(k = Kp, Ti = Ti, yMax = 1, yMin = 0, controllerType = Modelica.Blocks.Types.SimpleController.PI, y_start = 0.6) annotation(
      Placement(transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu = 2) annotation(
      Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Step step(height = 10, startTime = 1) annotation(
      Placement(transformation(origin = {-82, 32}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(sawTooth.y, greater.u2) annotation(
      Line(points = {{2, -50}, {12, -50}, {12, -8}, {28, -8}}, color = {0, 0, 127}));
    connect(greater.y, control_output) annotation(
      Line(points = {{52, 0}, {90, 0}}, color = {255, 0, 255}));
    connect(PID.y, greater.u1) annotation(
      Line(points = {{-5, 0}, {28, 0}}, color = {0, 0, 127}));
    connect(PID.u_m, measure) annotation(
      Line(points = {{-16, -12}, {-16, -30}, {-100, -30}}, color = {0, 0, 127}));
    connect(multiSum.y, PID.u_s) annotation(
      Line(points = {{-38, 0}, {-28, 0}}, color = {0, 0, 127}));
    connect(const.y, multiSum.u[1]) annotation(
      Line(points = {{-70, 0}, {-60, 0}}, color = {0, 0, 127}));
    connect(step.y, multiSum.u[2]) annotation(
      Line(points = {{-70, 32}, {-66, 32}, {-66, 0}, {-60, 0}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "4.1.0")),
      Icon(graphics = {Rectangle(lineColor = {255, 0, 255}, lineThickness = 3, extent = {{-100, 100}, {100, -100}}), Text(textColor = {255, 0, 0}, extent = {{-100, 100}, {100, -100}}, textString = "PI"), Text(origin = {0, -8}, textColor = {0, 0, 255}, extent = {{-150, 148}, {150, 108}}, textString = "%name")}),
      Diagram(graphics),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
  end control_antiwindup_PI_SPchange;

  model buck_example
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500) annotation(
      Placement(transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C(displayUnit = "uF") = 2.5e-4) annotation(
      Placement(transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L(displayUnit = "mH") = 0.12) annotation(
      Placement(transformation(origin = {-30, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
      Placement(transformation(origin = {134, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor icoil annotation(
      Placement(transformation(origin = {8, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100) annotation(
      Placement(transformation(origin = {-130, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor i_out annotation(
      Placement(transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
      Placement(transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
      Placement(transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanPulse booleanPulse(width = 60, period(displayUnit = "ms") = 0.001) annotation(
      Placement(transformation(origin = {-134, 72}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor i_in annotation(
      Placement(transformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_in annotation(
      Placement(transformation(origin = {-162, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(constantVoltage.p, i_in.p) annotation(
      Line(points = {{-130, 20}, {-130, 40}, {-120, 40}}, color = {0, 0, 255}));
    connect(i_in.n, switch.p) annotation(
      Line(points = {{-100, 40}, {-90, 40}}, color = {0, 0, 255}));
    connect(switch.n, inductor.p) annotation(
      Line(points = {{-70, 40}, {-40, 40}}, color = {0, 0, 255}));
    connect(inductor.n, icoil.p) annotation(
      Line(points = {{-20, 40}, {-2, 40}}, color = {0, 0, 255}));
    connect(icoil.n, i_out.p) annotation(
      Line(points = {{18, 40}, {50, 40}}, color = {0, 0, 255}));
    connect(i_out.n, resistor.p) annotation(
      Line(points = {{70, 40}, {90, 40}, {90, 20}}, color = {0, 0, 255}));
    connect(v_out.p, i_out.n) annotation(
      Line(points = {{134, 18}, {134, 40}, {70, 40}}, color = {0, 0, 255}));
    connect(constantVoltage.n, ground.p) annotation(
      Line(points = {{-130, 0}, {-130, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(ground.p, v_out.n) annotation(
      Line(points = {{-90, -20}, {134, -20}, {134, -2}}, color = {0, 0, 255}));
    connect(diode.n, inductor.p) annotation(
      Line(points = {{-50, 20}, {-50, 40}, {-40, 40}}, color = {0, 0, 255}));
    connect(capacitor.p, icoil.n) annotation(
      Line(points = {{30, 20}, {30, 40}, {18, 40}}, color = {0, 0, 255}));
    connect(diode.p, ground.p) annotation(
      Line(points = {{-50, 0}, {-50, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(capacitor.n, ground.p) annotation(
      Line(points = {{30, 0}, {30, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(resistor.n, ground.p) annotation(
      Line(points = {{90, 0}, {90, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(v_in.p, i_in.p) annotation(
      Line(points = {{-162, 20}, {-162, 40}, {-120, 40}}, color = {0, 0, 255}));
    connect(v_in.n, ground.p) annotation(
      Line(points = {{-162, 0}, {-162, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(booleanPulse.y, switch.control) annotation(
      Line(points = {{-122, 72}, {-80, 72}, {-80, 52}}, color = {255, 0, 255}));
    annotation(
      uses(Modelica(version = "4.1.0")),
      Diagram(coordinateSystem(extent = {{-180, 100}, {160, -40}})),
      version = "");
  end buck_example;

  model buck_losses
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500) annotation(
      Placement(transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C(displayUnit = "uF") = 2.5e-4) annotation(
      Placement(transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L(displayUnit = "mH") = 0.12) annotation(
      Placement(transformation(origin = {-36, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
      Placement(transformation(origin = {134, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor icoil annotation(
      Placement(transformation(origin = {16, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100) annotation(
      Placement(transformation(origin = {-130, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor i_out annotation(
      Placement(transformation(origin = {60, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
    Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
      Placement(transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
      Placement(transformation(origin = {-80, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
    Modelica.Blocks.Sources.BooleanPulse booleanPulse(width = 60, period(displayUnit = "ms") = 0.001) annotation(
      Placement(transformation(origin = {-98, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor i_in annotation(
      Placement(transformation(origin = {-110, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_in annotation(
      Placement(transformation(origin = {-162, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 0) annotation(
      Placement(transformation(origin = {-10, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.MultiProduct Power_out(nu = 2) annotation(
      Placement(transformation(origin = {170, 52}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.MultiProduct Power_in(nu = 2) annotation(
      Placement(transformation(origin = {-162, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Continuous.Integrator E_out annotation(
      Placement(transformation(origin = {210, 52}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.Integrator E_in annotation(
      Placement(transformation(origin = {-162, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Continuous.Derivative av_Pin annotation(
      Placement(transformation(origin = {-118, 136}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.Derivative av_Pout annotation(
      Placement(transformation(origin = {244, 52}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Units.SI.Power P_in;
    Modelica.Units.SI.Power P_out;
    Modelica.Units.SI.Power P_loss;
    Real En_in(start = 0);
    Real P_in_avg;
  equation
    connect(constantVoltage.p, i_in.p) annotation(
      Line(points = {{-130, 20}, {-130, 40}, {-120, 40}}, color = {0, 0, 255}));
    connect(i_in.n, switch.p) annotation(
      Line(points = {{-100, 40}, {-90, 40}}, color = {0, 0, 255}));
    connect(switch.n, inductor.p) annotation(
      Line(points = {{-70, 40}, {-46, 40}}, color = {0, 0, 255}));
    connect(icoil.n, i_out.p) annotation(
      Line(points = {{26, 40}, {50, 40}}, color = {0, 0, 255}));
    connect(i_out.n, resistor.p) annotation(
      Line(points = {{70, 40}, {90, 40}, {90, 20}}, color = {0, 0, 255}));
    connect(v_out.p, i_out.n) annotation(
      Line(points = {{134, 18}, {134, 40}, {70, 40}}, color = {0, 0, 255}));
    connect(constantVoltage.n, ground.p) annotation(
      Line(points = {{-130, 0}, {-130, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(ground.p, v_out.n) annotation(
      Line(points = {{-90, -20}, {134, -20}, {134, -2}}, color = {0, 0, 255}));
    connect(diode.n, inductor.p) annotation(
      Line(points = {{-50, 20}, {-50, 40}, {-46, 40}}, color = {0, 0, 255}));
    connect(capacitor.p, icoil.n) annotation(
      Line(points = {{30, 20}, {30, 40}, {26, 40}}, color = {0, 0, 255}));
    connect(diode.p, ground.p) annotation(
      Line(points = {{-50, 0}, {-50, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(capacitor.n, ground.p) annotation(
      Line(points = {{30, 0}, {30, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(resistor.n, ground.p) annotation(
      Line(points = {{90, 0}, {90, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(v_in.p, i_in.p) annotation(
      Line(points = {{-162, 20}, {-162, 40}, {-120, 40}}, color = {0, 0, 255}));
    connect(v_in.n, ground.p) annotation(
      Line(points = {{-162, 0}, {-162, -20}, {-90, -20}}, color = {0, 0, 255}));
    connect(inductor.n, resistor1.p) annotation(
      Line(points = {{-26, 40}, {-20, 40}}, color = {0, 0, 255}));
    connect(resistor1.n, icoil.p) annotation(
      Line(points = {{0, 40}, {6, 40}}, color = {0, 0, 255}));
    connect(v_out.v, Power_out.u[1]) annotation(
      Line(points = {{146, 8}, {148, 8}, {148, 52}, {160, 52}}, color = {0, 0, 127}));
    connect(i_out.i, Power_out.u[2]) annotation(
      Line(points = {{60, 52}, {160, 52}}, color = {0, 0, 127}));
    connect(booleanPulse.y, switch.control) annotation(
      Line(points = {{-87, 2}, {-80, 2}, {-80, 28}}, color = {255, 0, 255}));
    connect(i_in.i, Power_in.u[1]) annotation(
      Line(points = {{-110, 52}, {-162, 52}, {-162, 68}}, color = {0, 0, 127}));
    connect(v_in.v, Power_in.u[2]) annotation(
      Line(points = {{-172, 10}, {-184, 10}, {-184, 50}, {-162, 50}, {-162, 68}}, color = {0, 0, 127}));
    connect(Power_out.y, E_out.u) annotation(
      Line(points = {{182, 52}, {198, 52}}, color = {0, 0, 127}));
    connect(Power_in.y, E_in.u) annotation(
      Line(points = {{-162, 90}, {-162, 106}}, color = {0, 0, 127}));
    connect(E_out.y, av_Pout.u) annotation(
      Line(points = {{222, 52}, {232, 52}}, color = {0, 0, 127}));
    connect(E_in.y, av_Pin.u) annotation(
      Line(points = {{-162, 130}, {-162, 136}, {-130, 136}}, color = {0, 0, 127}));
    P_in = v_in.v*i_in.i;
    P_out = v_out.v*i_out.i;
    P_loss = P_in - P_out;
    der(En_in) = P_in;
    P_in_avg = if time > 0 then En_in/time else 0;
    annotation(
      uses(Modelica(version = "4.1.0")),
      Diagram(coordinateSystem(extent = {{-180, 140}, {220, -40}})),
      version = "",
      experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.003));
  end buck_losses;

  model buck_closedLoop_P
    buck buck1 annotation(
      Placement(transformation(origin = {0, 14}, extent = {{-26, -26}, {26, 26}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100) annotation(
      Placement(transformation(origin = {-52, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_in annotation(
      Placement(transformation(origin = {-84, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500) annotation(
      Placement(transformation(origin = {52, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
      Placement(transformation(origin = {82, 14}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    control_antiwindup_P control_antiwindup_P1(setpoint = 80, Kp = 0.01) annotation(
      Placement(transformation(origin = {36, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  equation
    connect(constantVoltage.p, buck1.buck_input) annotation(
      Line(points = {{-52, 24}, {-52, 32}, {-26, 32}}, color = {0, 0, 255}));
    connect(constantVoltage.n, buck1.buck_gnd_1) annotation(
      Line(points = {{-52, 4}, {-52, -4}, {-26, -4}}, color = {0, 0, 255}));
    connect(v_in.p, buck1.buck_input) annotation(
      Line(points = {{-84, 22}, {-84, 32}, {-26, 32}}, color = {0, 0, 255}));
    connect(v_in.n, buck1.buck_gnd_1) annotation(
      Line(points = {{-84, 2}, {-84, -4}, {-26, -4}}, color = {0, 0, 255}));
    connect(resistor.p, buck1.buck_out) annotation(
      Line(points = {{52, 24}, {52, 32}, {26, 32}}, color = {0, 0, 255}));
    connect(resistor.n, buck1.buck_gnd_2) annotation(
      Line(points = {{52, 4}, {52, -4}, {26, -4}}, color = {0, 0, 255}));
    connect(v_out.n, buck1.buck_gnd_2) annotation(
      Line(points = {{82, 4}, {82, -4}, {26, -4}}, color = {0, 0, 255}));
    connect(v_out.p, buck1.buck_out) annotation(
      Line(points = {{82, 24}, {82, 32}, {26, 32}}, color = {0, 0, 255}));
    connect(control_antiwindup_P1.control_output, buck1.u) annotation(
      Line(points = {{25, -40}, {0, -40}, {0, -18}}, color = {255, 0, 255}));
    connect(v_out.v, control_antiwindup_P1.measure) annotation(
      Line(points = {{94, 14}, {102, 14}, {102, -40}, {48, -40}}, color = {0, 0, 127}));
    annotation(
      experiment(StartTime = 0, StopTime = 0.2, Tolerance = 1e-06, Interval = 0.002));
  end buck_closedLoop_P;

  model buck_closedLoop_PI
    buck buck1 annotation(
      Placement(transformation(origin = {28, -14}, extent = {{-26, -26}, {26, 26}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100) annotation(
      Placement(transformation(origin = {-24, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_in annotation(
      Placement(transformation(origin = {-56, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500) annotation(
      Placement(transformation(origin = {80, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
      Placement(transformation(origin = {110, -14}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    control_antiwindup control_antiwindup1(Kp = 0.05, setpoint = 40, Ti = 0.01, frequency = 500) annotation(
      Placement(transformation(origin = {52, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  equation
    connect(constantVoltage.p, buck1.buck_input) annotation(
      Line(points = {{-24, -4}, {-24, 4}, {2, 4}}, color = {0, 0, 255}));
    connect(constantVoltage.n, buck1.buck_gnd_1) annotation(
      Line(points = {{-24, -24}, {-24, -32}, {2, -32}}, color = {0, 0, 255}));
    connect(v_in.p, buck1.buck_input) annotation(
      Line(points = {{-56, -6}, {-56, 4}, {2, 4}}, color = {0, 0, 255}));
    connect(v_in.n, buck1.buck_gnd_1) annotation(
      Line(points = {{-56, -26}, {-56, -32}, {2, -32}}, color = {0, 0, 255}));
    connect(resistor.p, buck1.buck_out) annotation(
      Line(points = {{80, -4}, {80, 4}, {54, 4}}, color = {0, 0, 255}));
    connect(resistor.n, buck1.buck_gnd_2) annotation(
      Line(points = {{80, -24}, {80, -32}, {54, -32}}, color = {0, 0, 255}));
    connect(v_out.n, buck1.buck_gnd_2) annotation(
      Line(points = {{110, -24}, {110, -32}, {54, -32}}, color = {0, 0, 255}));
    connect(v_out.p, buck1.buck_out) annotation(
      Line(points = {{110, -4}, {110, 4}, {54, 4}}, color = {0, 0, 255}));
    connect(v_out.v, control_antiwindup1.measure) annotation(
      Line(points = {{122, -14}, {126, -14}, {126, -78}, {64, -78}}, color = {0, 0, 127}));
    connect(buck1.u, control_antiwindup1.control_output) annotation(
      Line(points = {{28, -45.2}, {28, -78.2}, {42, -78.2}}, color = {255, 0, 255}));
    annotation(
      uses(Modelica(version = "4.1.0")),
      experiment(StartTime = 0, StopTime = 0.5, Tolerance = 1e-06, Interval = 0.001),
      Diagram(coordinateSystem(extent = {{-140, 60}, {140, -120}})),
      version = "");
  end buck_closedLoop_PI;

  model buck_closedLoop_PI_SPchange
    buck buck1 annotation(
      Placement(transformation(origin = {0, 14}, extent = {{-26, -26}, {26, 26}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100) annotation(
      Placement(transformation(origin = {-52, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_in annotation(
      Placement(transformation(origin = {-84, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500) annotation(
      Placement(transformation(origin = {52, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
      Placement(transformation(origin = {82, 14}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    control_antiwindup_PI_SPchange control_antiwindup_PI_SPchange1(Ti = 0.01, Kp = 0.5, setpoint = 60, frequency = 500) annotation(
      Placement(transformation(origin = {54, -50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  equation
    connect(constantVoltage.p, buck1.buck_input) annotation(
      Line(points = {{-52, 24}, {-52, 32}, {-26, 32}}, color = {0, 0, 255}));
    connect(constantVoltage.n, buck1.buck_gnd_1) annotation(
      Line(points = {{-52, 4}, {-52, -4}, {-26, -4}}, color = {0, 0, 255}));
    connect(v_in.p, buck1.buck_input) annotation(
      Line(points = {{-84, 22}, {-84, 32}, {-26, 32}}, color = {0, 0, 255}));
    connect(v_in.n, buck1.buck_gnd_1) annotation(
      Line(points = {{-84, 2}, {-84, -4}, {-26, -4}}, color = {0, 0, 255}));
    connect(resistor.p, buck1.buck_out) annotation(
      Line(points = {{52, 24}, {52, 32}, {26, 32}}, color = {0, 0, 255}));
    connect(resistor.n, buck1.buck_gnd_2) annotation(
      Line(points = {{52, 4}, {52, -4}, {26, -4}}, color = {0, 0, 255}));
    connect(v_out.n, buck1.buck_gnd_2) annotation(
      Line(points = {{82, 4}, {82, -4}, {26, -4}}, color = {0, 0, 255}));
    connect(v_out.p, buck1.buck_out) annotation(
      Line(points = {{82, 24}, {82, 32}, {26, 32}}, color = {0, 0, 255}));
    connect(v_out.v, control_antiwindup_PI_SPchange1.measure) annotation(
      Line(points = {{94, 14}, {100, 14}, {100, -50}, {66, -50}}, color = {0, 0, 127}));
    connect(control_antiwindup_PI_SPchange1.control_output, buck1.u) annotation(
      Line(points = {{44, -50}, {0, -50}, {0, -18}}, color = {255, 0, 255}));
    annotation(
      experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-06, Interval = 0.002));
  end buck_closedLoop_PI_SPchange;

  model buck_closedLoop_PI_LR
    buck buck1 annotation(
      Placement(transformation(origin = {0, 14}, extent = {{-26, -26}, {26, 26}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100) annotation(
      Placement(transformation(origin = {-84, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500) annotation(
      Placement(transformation(origin = {52, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
      Placement(transformation(origin = {82, 14}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    control_antiwindup_PI control_antiwindup_PI1(Ti = 0.1, Kp = 0.5, frequency = 1000, setpoint = 60) annotation(
      Placement(transformation(origin = {48, -42}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 100) annotation(
      Placement(transformation(origin = {-66, 32}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 0.5, startValue = false) annotation(
      Placement(transformation(origin = {-120, 22}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
      Placement(transformation(origin = {-40, 16}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
    Modelica.Electrical.Analog.Ideal.IdealTwoWaySwitch switch annotation(
      Placement(transformation(origin = {-84, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  equation
    connect(resistor.p, buck1.buck_out) annotation(
      Line(points = {{52, 24}, {52, 32}, {26, 32}}, color = {0, 0, 255}));
    connect(resistor.n, buck1.buck_gnd_2) annotation(
      Line(points = {{52, 4}, {52, -4}, {26, -4}}, color = {0, 0, 255}));
    connect(v_out.n, buck1.buck_gnd_2) annotation(
      Line(points = {{82, 4}, {82, -4}, {26, -4}}, color = {0, 0, 255}));
    connect(v_out.p, buck1.buck_out) annotation(
      Line(points = {{82, 24}, {82, 32}, {26, 32}}, color = {0, 0, 255}));
    connect(v_out.v, control_antiwindup_PI1.measure) annotation(
      Line(points = {{94, 14}, {108, 14}, {108, -42}, {60, -42}}, color = {0, 0, 127}));
    connect(control_antiwindup_PI1.control_output, buck1.u) annotation(
      Line(points = {{37, -42}, {0, -42}, {0, -18}}, color = {255, 0, 255}));
    connect(voltageSensor.n, buck1.buck_gnd_1) annotation(
      Line(points = {{-40, 6}, {-40, -4}, {-26, -4}}, color = {0, 0, 255}));
    connect(voltageSensor.p, buck1.buck_input) annotation(
      Line(points = {{-40, 26}, {-40, 32}, {-26, 32}}, color = {0, 0, 255}));
    connect(switch.p, constantVoltage.p) annotation(
      Line(points = {{-84, 12}, {-84, 6}}, color = {0, 0, 255}));
    connect(booleanStep.y, switch.control) annotation(
      Line(points = {{-109, 22}, {-96, 22}}, color = {255, 0, 255}));
  connect(constantVoltage.n, buck1.buck_gnd_1) annotation(
      Line(points = {{-84, -14}, {-84, -20}, {-50, -20}, {-50, -4}, {-26, -4}}, color = {0, 0, 255}));
  connect(switch.n1, buck1.buck_input) annotation(
      Line(points = {{-88, 32}, {-88, 48}, {-40, 48}, {-40, 32}, {-26, 32}}, color = {0, 0, 255}));
  connect(switch.n2, constantVoltage1.n) annotation(
      Line(points = {{-84, 32}, {-76, 32}}, color = {0, 0, 255}));
  connect(constantVoltage1.p, buck1.buck_input) annotation(
      Line(points = {{-56, 32}, {-26, 32}}, color = {0, 0, 255}));
    annotation(
      experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-06, Interval = 0.002),
      Diagram(coordinateSystem(extent = {{-140, 80}, {120, -60}})));
  end buck_closedLoop_PI_LR;
  annotation(
    uses(Modelica(version = "4.1.0")));
end BuckConverter;
