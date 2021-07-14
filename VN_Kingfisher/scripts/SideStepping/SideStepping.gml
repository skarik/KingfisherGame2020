function SideSteppingInit ()
{
	// Start with empty sidestep listing.
	SideStep = {
		listing : [],
	};
}

function SideSteppingStep ()
{
	for (var listingIndex = 0; listingIndex < array_length(Routines.SideStep.listing); ++listingIndex)
	{
		var routineInfo = Routines.SideStep.listing[listingIndex];
		if (routineInfo.valid)
		{
			// Run the calls within the given context.
			with (routineInfo.ctx)
			{
				if (!routineInfo.quitCall())
				{
					routineInfo.stepCall();
				}
				else
				{
					routineInfo.valid = false;
				}
			}
		}
	}
}

/// @function CreateOnStep ( context, callOnStep, quitWhenTrue )
/// @param context			Context to run in
/// @param callOnStep		Call to run each step
/// @param quitWhenTrue		Call to use to check when to end the call
/// @returns Routine handle
function CreateOnStep ( context, callOnStep, quitWhenTrue )
{
	var first_free_index = 0;
	for (var listingIndex = 0; listingIndex < array_length(Routines.SideStep.listing); ++listingIndex)
	{
		if (!listingIndex.valid)
		{
			first_free_index = listingIndex;
			break;
		}
	}
	
	var stepper_index = first_free_index;
	Routines.SideStep.listing[first_free_index] = {
		valid: true,
		ctx: context,
		stepCall: callOnStep,
		quitCall: quitWhenTrue,
	};
	
	return stepper_index;
}

/// @function StopOnStep ( routine )
/// @param routine			Routine to kill
function StopOnStep ( routine )
{
	Routines.SideStep.listing[routine].valid = false;
}