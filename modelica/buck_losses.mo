model buck_losses
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500)  annotation(
    Placement(transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C(displayUnit = "uF") = 2.5e-4)  annotation(
    Placement(transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L(displayUnit = "mH") = 0.12)  annotation(
    Placement(transformation(origin = {-36, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
    Placement(transformation(origin = {134, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor icoil annotation(
    Placement(transformation(origin = {16, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100)  annotation(
    Placement(transformation(origin = {-130, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i_out annotation(
    Placement(transformation(origin = {60, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
    Placement(transformation(origin = {-80, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(width = 60, period (displayUnit = "ms")= 0.001)  annotation(
    Placement(transformation(origin = {-98, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i_in annotation(
    Placement(transformation(origin = {-110, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor v_in annotation(
    Placement(transformation(origin = {-162, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 0) annotation(
    Placement(transformation(origin = {-10, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.MultiProduct Power_out(nu = 2)  annotation(
    Placement(transformation(origin = {170, 52}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.MultiProduct Power_in(nu = 2)  annotation(
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
  Real En_in(start=0);
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
  P_in = v_in.v * i_in.i;
  P_out = v_out.v * i_out.i;
  P_loss = P_in - P_out;
  der(En_in) = P_in;
  P_in_avg = if time > 0 then En_in / time else 0;

annotation(
    uses(Modelica(version = "4.1.0")),
  Diagram(coordinateSystem(extent = {{-180, 140}, {220, -40}})),
  version = "",
  experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.003));
end buck_losses;
