--u_execScript("OtherPatterns/babaPatterns/zcustomWallFractalRequirements.lua")

function wImpGenerateFractal(mFreqWalls, mSides, mSidewidth, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, bIsMainColor, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			wImpWallFrac(i + (a * mSideCurvature), mSidewidth, 0, 0, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, 0, 0, 0, 0, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
	end

end

function wImpGenerateFractalDistCurve(mFreqWalls, mSides, mSidewidth, mSideInc, mThickness, mDistanceStart, mDistCurve, mDistStartCurve, mDistStartIncCurve, mDistanceSpeedCurve, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, bIsMainColor, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1 do
		for i = 1, mSides do
			wImpWallFrac(i + (a * mSideInc), mSidewidth, 0, 0, mDistanceStart + (a * mDistanceInc), mDistCurve, mDistStartCurve, mDistStartCurve + (a * mDistStartIncCurve), mDistanceSpeedCurve, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, 0, 0, 0, 0, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
	end

end

function wImpGenerateFractalCurve(mFreqWalls, mSides, mSidewidth, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, mCurve, mCurveStart, mCurveStartInc, mCurveSpeed, bIsMainColor, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			wImpWallFrac(i + (a * mSideCurvature), mSidewidth, 0, 0, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, mCurve, mCurveStart, mCurveStart + (a * mCurveStartInc), mCurveSpeed, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
	end

end

function wImpGenerateFractalWidths(mFreqWalls, mSides, mSidewidthBase, mSidewidthThickness, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, bIsMainColor, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			wImpWallFrac(i + (a * mSideCurvature), 0, mSidewidthBase, mSidewidthThickness, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, 0, 0, 0, 0, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
	end

end

function wImpGenerateFractalVertexColor(mFreqWalls, mSides, mSidewidth, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRedA, mGreenA, mBlueA, mAlphaA, mRedB, mGreenB, mBlueB, mAlphaB, mRedC, mGreenC, mBlueC, mAlphaC, mRedD, mGreenD, mBlueD, mAlphaD, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			wImpWallFrac(i + (a * mSideCurvature), mSidewidth, 0, 0, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, 0, 0, 0, 0, 0, 1, mRedA, mGreenA, mBlueA, mAlphaA, mRedB, mGreenB, mBlueB, mAlphaB, mRedC, mGreenC, mBlueC, mAlphaC, mRedD, mGreenD, mBlueD, mAlphaD, mTimerBeforeDELETE or math.huge)
		end
	end

end

function tImpGenerateFractal(mFreqWalls, mSides, mSidewidth, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, bIsMainColor, mDelayTime, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			tImpWallFrac(i + (a * mSideCurvature), mSidewidth, 0, 0, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, 0, 0, 0, 0, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
		t_wait(mDelayTime or 0);
	end

end

function tImpGenerateFractalDistCurve(mFreqWalls, mSides, mSidewidth, mSideInc, mThickness, mDistanceStart, mDistCurve, mDistStartCurve, mDistStartIncCurve, mDistanceSpeedCurve, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, bIsMainColor, mDelayTime, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1 do
		for i = 1, mSides do
			tImpWallFrac(i + (a * mSideInc), mSidewidth, 0, 0, mDistanceStart + (a * mDistanceInc), mDistCurve, mDistStartCurve, mDistStartCurve + (a * mDistStartIncCurve), mDistanceSpeedCurve, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, 0, 0, 0, 0, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
		t_wait(mDelayTime or 0);
	end

end

function tImpGenerateFractalCurve(mFreqWalls, mSides, mSidewidth, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, mCurve, mCurveStart, mCurveStartInc, mCurveSpeed, bIsMainColor, mDelayTime, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			tImpWallFrac(i + (a * mSideCurvature), mSidewidth, 0, 0, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, mCurve, mCurveStart, mCurveStart + (a * mCurveStartInc), mCurveSpeed, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
		t_wait(mDelayTime or 0);
	end

end

function tImpGenerateFractalWidths(mFreqWalls, mSides, mSidewidthBase, mSidewidthThickness, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, bIsMainColor, mDelayTime, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			tImpWallFrac(i + (a * mSideCurvature), 0, mSidewidthBase, mSidewidthThickness, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, 0, 0, 0, 0, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
		t_wait(mDelayTime or 0);
	end

end

function tImpGenerateFractalVertexColor(mFreqWalls, mSides, mSidewidth, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRedA, mGreenA, mBlueA, mAlphaA, mRedB, mGreenB, mBlueB, mAlphaB, mRedC, mGreenC, mBlueC, mAlphaC, mRedD, mGreenD, mBlueD, mAlphaD, mDelayTime, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			tImpWallFrac(i + (a * mSideCurvature), mSidewidth, 0, 0, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, 0, 0, 0, 0, 1, 0, mRedA, mGreenA, mBlueA, mAlphaA, mRedB, mGreenB, mBlueB, mAlphaB, mRedC, mGreenC, mBlueC, mAlphaC, mRedD, mGreenD, mBlueD, mAlphaD, mTimerBeforeDELETE or math.huge)
		end
		t_wait(mDelayTime or 0);
	end

end


-- this is a very special fractal. it combines all the values in the fractals above, so you can get really crazy with it!
-- the drawback however is the sheer amount of values to keep track of, so it might get super annoying to use if you cant keep track, however
-- i feel the crazy shit you can make with this is worth it

-- over time this function will gain more values.

function wImpGenerateFractalCombination(mFreqWalls, mSides, mSidewidthBase, mSidewidthThickness, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, mCurve, mCurveStart, mCurveStartInc, mCurveSpeed, bIsMainColor, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			wImpWallFrac(i + (a * mSideCurvature), 0, mSidewidthBase, mSidewidthThickness, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, mCurve, mCurveStart, mCurveStart + (a * mCurveStartInc), mCurveSpeed, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
	end

end

function tImpGenerateFractalCombination(mFreqWalls, mSides, mSidewidthBase, mSidewidthThickness, mSideCurvature, mThickness, mDistanceStart, mDistanceInc, mDistanceBeginAnima, bIsAnimated, mRed, mGreen, mBlue, mAlpha, mCurve, mCurveStart, mCurveStartInc, mCurveSpeed, bIsMainColor, mDelayTime, mTimerBeforeDELETE)
	for a = 0, mFreqWalls - 1, 1 do
		for i = 1, mSides, 1 do
			tImpWallFrac(i + (a * mSideCurvature), 0, mSidewidthBase, mSidewidthThickness, mDistanceStart + (a * mDistanceInc), 0, 0, 0, 0, mDistanceBeginAnima, bIsAnimated, 0, mThickness, mSides, mCurve, mCurveStart, mCurveStart + (a * mCurveStartInc), mCurveSpeed, 0, bIsMainColor, mRed, mGreen, mBlue, mAlpha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mTimerBeforeDELETE or math.huge)
		end
		t_wait(mDelayTime or 0);
	end

end



