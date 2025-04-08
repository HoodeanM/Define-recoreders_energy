#Hoodean Malekzadeh#
# column Recorders
eval "recorder EnvelopeElement -file $dataDir/botClmnDeform.txt -ele $colBotEleList section 1 deformation"
eval "recorder EnvelopeElement -file $dataDir/topClmnDeform.txt -ele $colTopEleList section $numIntgrPts deformation"

eval "recorder EnvelopeElement -file $dataDir/botClmnForce.txt -ele $colBotEleList force"
eval "recorder EnvelopeElement -file $dataDir/topClmnForce.txt -ele $colTopEleList force"


eval "recorder EnvelopeDrift -file $dataDir/colDriftX.txt -iNode $botColNodeList -jNode $topColNodeList -dof 1 -perpDirn 3"
eval "recorder EnvelopeDrift -file $dataDir/colDriftY.txt -iNode $botColNodeList -jNode $topColNodeList -dof 2 -perpDirn 3"



# deck displacement (the most left nodes in the image)
eval "recorder EnvelopeNode -file $dataDir/deckNodeDisp.txt -node $deckNodeList -dof 1 2 disp"

# deck residual displacement (the most left nodes in the image)
eval "recorder ResidNode -file $dataDir/deckNodeResidualDispX.txt -node $deckNodeList -dof 1 disp"
eval "recorder ResidNode -file $dataDir/deckNodeResidualDispY.txt -node $deckNodeList -dof 2 disp"




# abutment displacement (the center nodes in the image)
eval "recorder EnvelopeNode -file $dataDir/abutNodeDisp.txt -node $abutNodeList -dof 1 2 disp"

# abutment residual displacement (the center nodes in the image)
eval "recorder ResidNode -file $dataDir/abutNodeRsidualDispX.txt -node $abutNodeList -dof 1 disp"
eval "recorder ResidNode -file $dataDir/abutNodeRsidualDispY.txt -node $abutNodeList -dof 2 disp"



# shear key and bearing pad elements recorders (the left springs in the image)
eval "recorder EnvelopeElement -file $dataDir/shearKeyDeform.txt -ele $keyEleList deformation"
eval "recorder EnvelopeElement -file $dataDir/bearingDeform.txt -ele $bearingEleList deformation"

# rsidual bearing
eval "recorder ResidElement -file $dataDir/bearingResidualX.txt -ele $bearingEleList  material 1 strain"
eval "recorder ResidElement -file $dataDir/bearingResidualY.txt -ele $bearingEleList  material 2 strain"


# Foundation
eval "recorder EnvelopeElement -file $dataDir/foundEleDeform.txt -ele $foundEleList deformation"

# Abutment elements
# passive, active and transverse deformations of abutment (the right springs in the image)
eval "recorder EnvelopeElement -file $dataDir/abutEleDeform.txt -ele $soilEleList deformation"


# Time history results
file mkdir $dataDir/timeHistory
# nodes on center of bays
# bay 1
recorder Node -file "$dataDir/timeHistory/nodeDisp-bay1.txt" -time -node $bay1SampleNode -dof 1 disp
eval "recorder Node -file $dataDir/loadedNodeDispZ.txt -node $nodeHasLoad -dof 3 disp"

if {$hasHistoryRecorder} {

	recorder Node -file "$dataDir/timeHistory/nodeDisp-bay1.txt" -time -node $bay1SampleNode -dof 1 2 disp
	# bay 2
	recorder Node -file "$dataDir/timeHistory/nodeDisp-bay2.txt" -time -node $bay2SampleNode -dof 1 2 disp
	# bay 3
	recorder Node -file "$dataDir/timeHistory/nodeDisp-bay3.txt" -time -node $bay3SampleNode -dof 1 2 disp
	# bay 4
	# recorder Node -file "$dataDir/timeHistory/nodeDisp-bay4.txt" -time -node $bay4SampleNode -dof 1 2 disp



	# left
	recorder Element -file $dataDir/timeHistory/hysteresisPileLeft.txt   		 -ele $abutSampleEleLeft material 2 stressStrain
	recorder Element -file $dataDir/timeHistory/hysteresisAbutLongitudLeft.txt   -ele $abutSampleEleLeft material 1 stressStrain

	recorder Element -file $dataDir/timeHistory/hysteresisBearingLongitLeft.txt  -ele $bearSampleEleLeft material 1 stressStrain
	recorder Element -file $dataDir/timeHistory/hysteresisBearingTransvLeft.txt  -ele $bearSampleEleLeft material 2 stressStrain

	recorder Element -file $dataDir/timeHistory/hysteresisImpactLeft.txt   		 -ele $impactSampleEleLeft material 1 stressStrain
	recorder Element -file $dataDir/timeHistory/hysteresisShearKeyLeft.txt  	 -ele $keySampleEleLeft material 1 stressStrain

	# right
	recorder Element -file $dataDir/timeHistory/hysteresisPileRight.txt   		 -ele $abutSampleEleRight material 2 stressStrain
	recorder Element -file $dataDir/timeHistory/hysteresisAbutLongitudRight.txt   -ele $abutSampleEleRight material 1 stressStrain

	recorder Element -file $dataDir/timeHistory/hysteresisBearingLongitRight.txt  -ele $bearSampleEleRight material 1 stressStrain
	recorder Element -file $dataDir/timeHistory/hysteresisBearingTransvRight.txt  -ele $bearSampleEleRight material 2 stressStrain

	recorder Element -file $dataDir/timeHistory/hysteresisImpactRight.txt   		 -ele $impactSampleEleRight material 1 stressStrain
	recorder Element -file $dataDir/timeHistory/hysteresisShearKeyRight.txt  	 -ele $keySampleEleRight material 1 stressStrain


	# moment curvature for a random column
	recorder Element 		-file $dataDir/timeHistory/colTopSecDeform.txt -ele $columnSampleEle section $numIntgrPts deformation
	recorder Element 		-file $dataDir/timeHistory/colTopSecForce.txt -ele $columnSampleEle section $numIntgrPts forces
	recorder Element 		-file $dataDir/timeHistory/colTopEleForce.txt -ele $columnSampleEle force
	recorder Drift 	-file $dataDir/timeHistory/columnDriftX.txt -time -iNode $colSampleBotNode -jNode $colSampleTopNode -dof 1 -perpDirn 3
	recorder Drift 	-file $dataDir/timeHistory/globalDriftX.txt -time -iNode $colSampleBotNode -jNode $colSampleTopNode -dof 1 -perpDirn 3
	recorder Drift 	-file $dataDir/timeHistory/columnDriftY.txt -time -iNode $colSampleBotNode -jNode $colSampleTopNode -dof 2 -perpDirn 3
	recorder Drift 	-file $dataDir/timeHistory/globalDriftY.txt -time -iNode $colSampleBotNode -jNode $colSampleTopNode -dof 2 -perpDirn 3

	# accel at fixed base
	set iBay 1 ; set i 2 ; set j 0
	set nodeTag 11[set iBay][set i][set j]
	recorder Node -file $dataDir/timeHistory/fixedAccelX.txt -node $nodeTag -time -timeSeries $timeSeriesX -dof 1 accel
	recorder Node -file $dataDir/timeHistory/fixedAccelY.txt -node $nodeTag -time -timeSeries $timeSeriesY -dof 2 accel
	recorder Node -file $dataDir/timeHistory/fixedAccelZ.txt -node $nodeTag -time -timeSeries $timeSeriesZ -dof 3 accel


	# node velocity and acceleration
	eval "recorder Node -file $dataDir/timeHistory/nodesDispX.txt -node $nodeHasMass -dof 1 disp"
	eval "recorder Node -file $dataDir/timeHistory/nodesDispY.txt -node $nodeHasMass -dof 2 disp"
	eval "recorder Node -file $dataDir/timeHistory/nodesDispZ.txt -node $nodeHasMass -dof 3 disp"

	eval "recorder Node -file $dataDir/timeHistory/nodesVelocityX.txt -node $nodeHasMass -dof 1 vel"
	eval "recorder Node -file $dataDir/timeHistory/nodesVelocityY.txt -node $nodeHasMass -dof 2 vel"
	eval "recorder Node -file $dataDir/timeHistory/nodesVelocityZ.txt -node $nodeHasMass -dof 3 vel"

	eval "recorder Node -file $dataDir/timeHistory/nodesAccelX.txt -node $nodeHasMass -dof 1 accel"
	eval "recorder Node -file $dataDir/timeHistory/nodesAccelY.txt -node $nodeHasMass -dof 2 accel"
	eval "recorder Node -file $dataDir/timeHistory/nodesAccelZ.txt -node $nodeHasMass -dof 3 accel"
	
}





set outDir "$dataDir/hystereticEnergy"
file mkdir $outDir

# ------------ column energy -------------
eval "recorder ResidElement -file $outDir/colEnergy.txt  -process sum -ele $colEleList energy"

# ------------ zerolength energy -------------

# shear key 
eval "recorder ResidElement -file $outDir/shearKeyEnergy.txt 	-process sum -ele $keyEleList material 1 energy"

# bearing pad
eval "recorder ResidElement -file $outDir/bearingEnergyX.txt 	-process sum -ele $bearingEleList  material 1 energy"
eval "recorder ResidElement -file $outDir/bearingEnergyY.txt 	-process sum -ele $bearingEleList  material 2 energy"


#pile
eval "recorder ResidElement -file $outDir/pileEnergyX.txt 	-process sum -ele $pileEleList material 1 energy"
eval "recorder ResidElement -file $outDir/pileEnergyY.txt 	-process sum -ele $pileEleList material 2 energy"

#foundation
eval "recorder ResidElement -file $outDir/foundEnergyX.txt 	-process sum -ele $foundEleList material 1 energy"
eval "recorder ResidElement -file $outDir/foundEnergyY.txt 	-process sum -ele $foundEleList material 2 energy"
eval "recorder ResidElement -file $outDir/foundEnergyXX.txt 	-process sum -ele $foundEleList material 4 energy"
eval "recorder ResidElement -file $outDir/foundEnergyYY.txt 	-process sum -ele $foundEleList material 5 energy"


# deck
eval "recorder ResidElement -file $outDir/deckEnergy.txt  -process sum -ele $deckEleList energy"

# rigid elements
eval "recorder ResidElement -file $outDir/rigidEleEnergy.txt  -process sum -ele $rigidEleList energy"


# ------------ stress strain -------------

# soil
eval "recorder Element -file $outDir/soilStressStrain.txt -ele $soilEleList material 1 stressStrain"

# impact
eval "recorder Element -file $outDir/impactStressStrain.txt -ele $impactEleList material 1 stressStrain"


if {$hasHistoryRecorder} {

	set outDir "$dataDir/hystereticEnergyHistory"
	file mkdir $outDir

	# ------------ column energy -------------
	eval "recorder Element -file $outDir/colEnergy.txt -time	-process sum -ele $colEleList energy"

	# ------------ zerolength energy -------------

	# shear key 
	eval "recorder Element -file $outDir/shearKeyEnergy.txt -time	-process sum -ele $keyEleList material 1 energy"

	# bearing pad
	eval "recorder Element -file $outDir/bearingEnergyX.txt -time	-process sum -ele $bearingEleList  material 1 energy"
	eval "recorder Element -file $outDir/bearingEnergyY.txt -time	-process sum -ele $bearingEleList  material 2 energy"


	#pile
	eval "recorder Element -file $outDir/pileEnergyX.txt -time	-process sum -ele $pileEleList material 1 energy"
	eval "recorder Element -file $outDir/pileEnergyY.txt -time	-process sum -ele $pileEleList material 2 energy"

	#foundation
	eval "recorder Element -file $outDir/foundEnergyX.txt  -time	-process sum -ele $foundEleList material 1 energy"
	eval "recorder Element -file $outDir/foundEnergyY.txt  -time	-process sum -ele $foundEleList material 2 energy"
	eval "recorder Element -file $outDir/foundEnergyXX.txt -time 	-process sum -ele $foundEleList material 3 energy"
	eval "recorder Element -file $outDir/foundEnergyYY.txt -time 	-process sum -ele $foundEleList material 4 energy"

	eval "recorder Element -file $outDir/foundStressStrainX.txt  -time	-process sum -ele $foundEleList material 1 stressStrain"
	eval "recorder Element -file $outDir/foundStressStrainY.txt  -time	-process sum -ele $foundEleList material 2 stressStrain"
	eval "recorder Element -file $outDir/foundStressStrainXX.txt -time 	-process sum -ele $foundEleList material 3 stressStrain"
	eval "recorder Element -file $outDir/foundStressStrainYY.txt -time 	-process sum -ele $foundEleList material 4 stressStrain"


	# deck
	eval "recorder Element -file $outDir/deckEnergy.txt  -time -process sum -ele $deckEleList energy"

	# rigid elements
	eval "recorder Element -file $outDir/rigidEleEnergy.txt  -time -process sum -ele $rigidEleList energy"
}



set outDir "$dataDir/otherEnergy"
file mkdir $outDir

# node energy
set baseRecTag [eval "recorder EnvelopeNode -file $outDir/nodeKineticEnergy.txt			-time -process sum 	-node $nodeHasMass kineticEnergy"]
eval "recorder ResidNode -file $outDir/nodeDampingEnergy.txt 			-process sum 	-node $nodeHasMass dampingEnergy"
eval "recorder ResidNode -file $outDir/nodeInputEnergyResid.txt 	 	-process sum	-node $nodeHasMass -timeSeries $timeSeriesX $timeSeriesY $timeSeriesZ 0 0 0 motionEnergy"

# element energy
eval "recorder ResidElement -file $outDir/colDampingEnergy.txt  -process sum 		-ele $colEleList 		dampingEnergy"
eval "recorder ResidElement -file $outDir/rigidEleDampingEnergy.txt  -process sum 	-ele $rigidEleList 		dampingEnergy"
eval "recorder ResidElement -file $outDir/deckDampingEnergy.txt  -process sum 		-ele $deckEleList 		dampingEnergy"
eval "recorder ResidElement -file $outDir/shearKeyDamping.txt 	-process sum 		-ele $keyEleList 		dampingEnergy"
eval "recorder ResidElement -file $outDir/bearingDamping.txt 	-process sum 		-ele $bearingEleList  	dampingEnergy"
eval "recorder ResidElement -file $outDir/pileDamping.txt 		-process sum 		-ele $pileEleList 		dampingEnergy"
eval "recorder ResidElement -file $outDir/soilDamping.txt 		-process sum 		-ele $soilEleList 		dampingEnergy"
eval "recorder ResidElement -file $outDir/impactDamping.txt 	-process sum 		-ele $impactEleList 	dampingEnergy"
eval "recorder ResidElement -file $outDir/foundDamping.txt 		-process sum 		-ele $foundEleList 		dampingEnergy"


if {$hasHistoryRecorder} {

	# other energy history
	set outDir "$dataDir/otherEnergyHistory"
	file mkdir $outDir

	eval "recorder Node -file $outDir/nodeKineticEnergy.txt	-time	-process sum	-node $nodeHasMass  kineticEnergy"
	eval "recorder Node -file $outDir/nodeDampingEnergy.txt -time 	-process sum 	-node $nodeHasMass dampingEnergy"
	eval "recorder Node -file $outDir/nodeInputEnergy.txt   -time 	-process sum	-node $nodeHasMass -timeSeries $timeSeriesX $timeSeriesY $timeSeriesZ 0 0 0 motionEnergy"

	eval "recorder Element -file $outDir/colDampingEnergy.txt 		-time 	-process sum 	-ele $colEleList 		dampingEnergy"
	eval "recorder Element -file $outDir/rigidEleDampingEnergy.txt 	-time 	-process sum 	-ele $rigidEleList 		dampingEnergy"
	eval "recorder Element -file $outDir/deckDampingEnergy.txt 		-time 	-process sum 	-ele $deckEleList 		dampingEnergy"
	eval "recorder Element -file $outDir/shearKeyDamping.txt 		-time 	-process sum 	-ele $keyEleList 		dampingEnergy"
	eval "recorder Element -file $outDir/bearingDamping.txt 		-time 	-process sum 	-ele $bearingEleList 	dampingEnergy"
	eval "recorder Element -file $outDir/pileDamping.txt 			-time 	-process sum 	-ele $pileEleList 		dampingEnergy"
	eval "recorder Element -file $outDir/soilDamping.txt 			-time 	-process sum 	-ele $soilEleList 		dampingEnergy"
	eval "recorder Element -file $outDir/impactDamping.txt 			-time 	-process sum 	-ele $impactEleList 	dampingEnergy"
	eval "recorder Element -file $outDir/foundDamping.txt 			-time	-process sum 	-ele $foundEleList 		dampingEnergy"
}


# conditional energy
set outDir "$dataDir/conditionalEnergy"
file mkdir $outDir

eval "recorder ConditionalNode -file $outDir/nodeKineticEnergy.txt  -controlRecorder $baseRecTag 	-process sum	-node $nodeHasMass kineticEnergy"
eval "recorder ConditionalNode -file $outDir/nodeDampingEnergy.txt 	-controlRecorder $baseRecTag 	-process sum 	-node $nodeHasMass 		dampingEnergy"
eval "recorder ConditionalNode -file $outDir/nodeInputEnergy.txt   	-controlRecorder $baseRecTag 	-process sum	-node $nodeHasMass -timeSeries $timeSeriesX $timeSeriesY $timeSeriesZ 0 0 0 motionEnergy"

eval "recorder ConditionalElement -file $outDir/colDampingEnergy.txt  			-controlRecorder $baseRecTag 		-process sum 	-ele  $colEleList 		dampingEnergy"
eval "recorder ConditionalElement -file $outDir/rigidEleDampingEnergy.txt 		-controlRecorder $baseRecTag		-process sum 	-ele  $rigidEleList 		dampingEnergy"
eval "recorder ConditionalElement -file $outDir/deckDampingEnergy.txt 			-controlRecorder $baseRecTag		-process sum 	-ele  $deckEleList 		dampingEnergy"
eval "recorder ConditionalElement -file $outDir/shearKeyDamping.txt 			-controlRecorder $baseRecTag 		-process sum 	-ele  $keyEleList 		dampingEnergy"
eval "recorder ConditionalElement -file $outDir/bearingDamping.txt 				-controlRecorder $baseRecTag 		-process sum 	-ele  $bearingEleList  	dampingEnergy"
eval "recorder ConditionalElement -file $outDir/pileDamping.txt 				-controlRecorder $baseRecTag 		-process sum 	-ele  $pileEleList 		dampingEnergy"
eval "recorder ConditionalElement -file $outDir/soilDamping.txt 				-controlRecorder $baseRecTag 		-process sum 	-ele  $soilEleList 		dampingEnergy"
eval "recorder ConditionalElement -file $outDir/impactDamping.txt 				-controlRecorder $baseRecTag 		-process sum 	-ele  $impactEleList 	dampingEnergy"
eval "recorder ConditionalElement -file $outDir/foundDamping.txt 				-controlRecorder $baseRecTag 		-process sum 	-ele  $foundEleList 	dampingEnergy"

eval "recorder ConditionalElement -file $outDir/colHystereticEnergy.txt  		-controlRecorder $baseRecTag 		-process sum 	-ele  $colEleList 		energy"
eval "recorder ConditionalElement -file $outDir/deckHystereticEnergy.txt  		-controlRecorder $baseRecTag 		-process sum 	-ele  $deckEleList 		energy"
eval "recorder ConditionalElement -file $outDir/rigidEleHystereticEnergy.txt  	-controlRecorder $baseRecTag 		-process sum 	-ele  $rigidEleList 	energy"
eval "recorder ConditionalElement -file $outDir/shearKeyHysteretic.txt 			-controlRecorder $baseRecTag 		-process sum 	-ele  $keyEleList 		material 1 energy"
eval "recorder ConditionalElement -file $outDir/bearingHystereticX.txt 			-controlRecorder $baseRecTag 		-process sum 	-ele  $bearingEleList  	material 1 energy"
eval "recorder ConditionalElement -file $outDir/bearingHystereticY.txt 			-controlRecorder $baseRecTag 		-process sum 	-ele  $bearingEleList  	material 2 energy"
eval "recorder ConditionalElement -file $outDir/pileHystereticX.txt 			-controlRecorder $baseRecTag 		-process sum 	-ele  $pileEleList 		material 1 energy"
eval "recorder ConditionalElement -file $outDir/pileHystereticY.txt 			-controlRecorder $baseRecTag 		-process sum 	-ele  $pileEleList 		material 2 energy"
eval "recorder ConditionalElement -file $outDir/foundHystereticX.txt 			-controlRecorder $baseRecTag 		-process sum 	-ele  $foundEleList 	material 1 energy"
eval "recorder ConditionalElement -file $outDir/foundHystereticY.txt 			-controlRecorder $baseRecTag 		-process sum 	-ele  $foundEleList 	material 2 energy"
