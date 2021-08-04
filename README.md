# MATLAB---3phase-Generator-short-circuit-current-calculation
MATLAB script that calculates and visualizes a bolted three-phase Generator short-circuit current.
The Total short-circuit current is composed of Iac and Idc components.

The inputs to the function are:

- S which is the base apparent power in VA
- Ug is the Voltage in V
- percentageEg is the generator percentage operating voltage. For example: if The generator is operating at 5% above rated voltage, then percentageEg = 0.05, if the generator is operating at the rated voltage then percentageEg = 0 .
- f: working frequency in hertz
- Xsecond(x''d): direct axis subtransient reactance in p.u
- Xprime(x'd): direct axis transient reactance in p.u
- Xd(xd): direct axis synchronous reactance in p.u
- Tsecond(T''d): direct axis short circuit subtransient time constant in seconds
- Tprime(T'd): direct axis short circuit transient time constant in seconds
- Ta(Ta): Armature short circuit time constant in seconds
