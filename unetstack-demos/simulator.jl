# ----- Environment -----

using UnderwaterAcoustics

env = UnderwaterEnvironment(
  seabed = SandyClay,                 # sandy-clay seabed
  bathymetry = ConstantDepth(40.0)    # 40m water depth
)
pm = PekerisRayModel(env, 7)          # 7-ray Pekeris ray model

# ----- Simulation -----

using VirtualAcousticOcean

sim = Simulation(pm, 25000.0)                       # operating at 25 kHz nominal frequency
addnode!(sim, (0.0, 0.0, -10.0), GroguUDP, 9809)      # node 1 at surface
addnode!(sim, (0.0, 500.0, -30.0), GroguUDP, 9819)    # node 2 at 30 m depth,
addnode!(sim, (1000.0, 0.0, -30.0), GroguUDP, 9829)   # node 3 at 30 m depth,
addnode!(sim, (1000.0, 500.0, -30.0), GroguUDP, 9839) # node 4 at 30 m depth,
addnode!(sim, (1500.0, 0.0, -30.0), GroguUDP, 9849)   # node 5 at 30 m depth,
addnode!(sim, (1500.0, 500.0, -10.0), GroguUDP, 9859) # node 6 at surface
run(sim)                                            # start simulation (non-blocking)

# print node information
println("Simulation running with these nodes:")
for (idx, node) in enumerate(sim.nodes)
  println("  - Node $(idx) at position $(node.pos) receiving on UDP port $(node.conn.baseport)")
end

wait()                                              # wait for simulation to finish