/* ****************************************************************************
 * $Revision$:
 * $Author$:
 * $Date$:
 * $HeadURL$:
 * $Id$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- VALUE_SET_LOGIC_TO_APPLY_FIELDS=RES_FIELD_VALUE_1,RES_FIELD_VALUE_2,RES_FIELD_VALUE_3,RES_FIELD_VALUE_4,RES_FIELD_VALUE_5,RES_FIELD_VALUE_6,RES_FIELD_VALUE_7,RES_FIELD_VALUE_8,RES_FIELD_VALUE_9,RES_FIELD_VALUE_10,RES_FIELD_VALUE_11,RES_FIELD_VALUE_12,RES_FIELD_VALUE_13,RES_FIELD_VALUE_14,RES_FIELD_VALUE_15,RES_FIELD_VALUE_16,RES_FIELD_VALUE_17,RES_FIELD_VALUE_18,RES_FIELD_VALUE_19,RES_FIELD_VALUE_20

WITH EFF_STRUCTURE AS (SELECT context.CONTEXT_CODE
	,context.NAME CONTEXT_NAME
	,Segment.COLUMN_NAME
	,Segment.SEQUENCE_NUMBER
	,Segment.PROMPT
	,ValueSet.VALIDATION_TYPE
	,ValueSet.VALUE_SET_CODE
	,vsTables.ID_COLUMN_TYPE
	,ROW_NUMBER() OVER (PARTITION BY context.NAME ORDER BY Segment.SEQUENCE_NUMBER) R1
	FROM FND_DF_CONTEXTS_VL context 
	,FND_DF_SEGMENTS_VL Segment
	,FND_VS_VALUE_SETS ValueSet
	,FND_VS_VT_TABLE_EXT vsTables
	WHERE context.DESCRIPTIVE_FLEXFIELD_CODE = 'PER_JOBS_EIT_EFF'
	AND context.DESCRIPTIVE_FLEXFIELD_CODE = Segment.DESCRIPTIVE_FLEXFIELD_CODE
	AND context.CONTEXT_CODE = Segment.CONTEXT_CODE
	AND Segment.VALUE_SET_ID = ValueSet.VALUE_SET_ID(+)
	AND Segment.VALUE_SET_ID = vsTables.VALUE_SET_ID(+))
,STRUCTURE_WT_DATA AS (SELECT extraInfo.JOB_EXTRA_INFO_ID 
	,extraInfo.EFFECTIVE_START_DATE 
	,extraInfo.EFFECTIVE_END_DATE
	,eff.R1
	,eff.PROMPT FIELD_NAME
	,(CASE 
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION1' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION1 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION1
						END)
				ELSE
					extraInfo.JEI_INFORMATION1
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION2' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION2 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION2
						END)
				ELSE
					extraInfo.JEI_INFORMATION2
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION3' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION3 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION3
						END)
				ELSE
					extraInfo.JEI_INFORMATION3
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION4' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION4 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION4
						END)
				ELSE
					extraInfo.JEI_INFORMATION4
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION5' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION5 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION5
						END)
				ELSE
					extraInfo.JEI_INFORMATION5
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION6' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION6 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION6
						END)
				ELSE
					extraInfo.JEI_INFORMATION6
				END)	
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION7' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION7 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION7
						END)
				ELSE
					extraInfo.JEI_INFORMATION7
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION8' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION8 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION8
						END)
				ELSE
					extraInfo.JEI_INFORMATION8
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION9' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION9 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION9
						END)
				ELSE
					extraInfo.JEI_INFORMATION9
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION10' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION10 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION10
						END)
				ELSE
					extraInfo.JEI_INFORMATION10
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION11' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION11 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION11
						END)
				ELSE
					extraInfo.JEI_INFORMATION11
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION12' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION12 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION12
						END)
				ELSE
					extraInfo.JEI_INFORMATION12
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION13' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION13 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION13
						END)
				ELSE
					extraInfo.JEI_INFORMATION13
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION14' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION14 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION14
						END)
				ELSE
					extraInfo.JEI_INFORMATION14
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION15' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION15 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION15
						END)
				ELSE
					extraInfo.JEI_INFORMATION15
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION16' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION16 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION16
						END)
				ELSE
					extraInfo.JEI_INFORMATION16
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION17' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION17 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION17
						END)
				ELSE
					extraInfo.JEI_INFORMATION17
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION18' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION18 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION18
						END)
				ELSE
					extraInfo.JEI_INFORMATION18
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION19' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION19 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION19
						END)
				ELSE
					extraInfo.JEI_INFORMATION19
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION20' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION20 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION20
						END)
				ELSE
					extraInfo.JEI_INFORMATION20
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION21' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION21 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION21
						END)
				ELSE
					extraInfo.JEI_INFORMATION21
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION22' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION22 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION22
						END)
				ELSE
					extraInfo.JEI_INFORMATION22
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION23' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION23 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION23
						END)
				ELSE
					extraInfo.JEI_INFORMATION23
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION24' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION24 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION24
						END)
				ELSE
					extraInfo.JEI_INFORMATION24
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION25' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION25 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION25
						END)
				ELSE
					extraInfo.JEI_INFORMATION25
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION26' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION26 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION26
						END)
				ELSE
					extraInfo.JEI_INFORMATION26
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION27' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION27 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION27
						END)
				ELSE
					extraInfo.JEI_INFORMATION27
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION28' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION28 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION28
						END)
				ELSE
					extraInfo.JEI_INFORMATION28
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION29' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION29 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION29
						END)
				ELSE
					extraInfo.JEI_INFORMATION29
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION30' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION30 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||extraInfo.JEI_INFORMATION30
						END)
				ELSE
					extraInfo.JEI_INFORMATION30
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER1' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER1 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER1)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER1)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER2' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER2 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER2)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER2)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER3' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER3 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER3)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER3)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER4' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER4 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER4)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER4)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER5' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER5 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER5)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER5)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER6' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER6 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER6)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER6)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER7' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER7 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER7)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER7)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER8' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER8 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER8)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER8)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER9' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER9 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER9)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER9)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER10' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER10 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER10)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER10)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER11' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER11 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER11)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER11)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER12' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER12 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER12)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER12)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER13' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER13 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER13)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER13)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER14' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER14 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER14)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER14)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER15' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER15 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER15)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER15)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER16' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER16 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER16)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER16)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER17' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER17 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER17)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER17)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER18' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER18 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER18)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER18)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER19' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER19 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER19)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER19)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_NUMBER20' THEN
			(CASE 
				WHEN eff.VALIDATION_TYPE = 'TABLE' THEN
					(CASE
						WHEN extraInfo.JEI_INFORMATION_NUMBER20 IS NOT NULL THEN 
							eff.VALUE_SET_CODE||'###R4C###'||TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER20)
						END)
				ELSE
					TO_CHAR(extraInfo.JEI_INFORMATION_NUMBER20)
				END)
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE1' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE1,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE2' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE2,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE3' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE3,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE4' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE4,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE5' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE5,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE6' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE6,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE7' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE7,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE8' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE8,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE9' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE9,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE10' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE10,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE11' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE11,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE12' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE12,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE13' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE13,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE14' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE14,'DD-Mon-YYYY')
		WHEN eff.COLUMN_NAME = 'JEI_INFORMATION_DATE15' THEN
			TO_CHAR(extraInfo.JEI_INFORMATION_DATE15,'DD-Mon-YYYY')
		END) FIELD_VALUE
	FROM PER_JOB_EXTRA_INFO_F extraInfo
	,EFF_STRUCTURE eff
	WHERE extraInfo.JEI_INFORMATION_CATEGORY = eff.CONTEXT_CODE)
	

SELECT JobDEO.name RES_NAME 
,JobDEO.JOB_CODE RES_CODE
,TO_CHAR(JobDEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY')  RES_EFFECTIVE_START_DATE
,TO_CHAR(JobDEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,(SELECT NAME
	FROM FND_DF_CONTEXTS_VL
	WHERE DESCRIPTIVE_FLEXFIELD_CODE = 'PER_JOBS_EIT_EFF'
	AND CONTEXT_CODE = perJOBEXTRAEO.JEI_INFORMATION_CATEGORY 
	) RES_EXTRA_INFORMATION_NAME

,VALUE1.FIELD_NAME RES_FIELD_NAME_1
,VALUE1.FIELD_VALUE RES_FIELD_VALUE_1
,VALUE2.FIELD_NAME RES_FIELD_NAME_2
,VALUE2.FIELD_VALUE RES_FIELD_VALUE_2
,VALUE3.FIELD_NAME RES_FIELD_NAME_3
,VALUE3.FIELD_VALUE RES_FIELD_VALUE_3
,VALUE4.FIELD_NAME RES_FIELD_NAME_4
,VALUE4.FIELD_VALUE RES_FIELD_VALUE_4
,VALUE5.FIELD_NAME RES_FIELD_NAME_5
,VALUE5.FIELD_VALUE RES_FIELD_VALUE_5
,VALUE6.FIELD_NAME RES_FIELD_NAME_6
,VALUE6.FIELD_VALUE RES_FIELD_VALUE_6
,VALUE7.FIELD_NAME RES_FIELD_NAME_7
,VALUE7.FIELD_VALUE RES_FIELD_VALUE_7
,VALUE8.FIELD_NAME RES_FIELD_NAME_8
,VALUE8.FIELD_VALUE RES_FIELD_VALUE_8
,VALUE9.FIELD_NAME RES_FIELD_NAME_9
,VALUE9.FIELD_VALUE RES_FIELD_VALUE_9
,VALUE10.FIELD_NAME RES_FIELD_NAME_10
,VALUE10.FIELD_VALUE RES_FIELD_VALUE_10
,VALUE11.FIELD_NAME RES_FIELD_NAME_11
,VALUE11.FIELD_VALUE RES_FIELD_VALUE_11
,VALUE12.FIELD_NAME RES_FIELD_NAME_12
,VALUE12.FIELD_VALUE RES_FIELD_VALUE_12
,VALUE13.FIELD_NAME RES_FIELD_NAME_13
,VALUE13.FIELD_VALUE RES_FIELD_VALUE_13
,VALUE14.FIELD_NAME RES_FIELD_NAME_14
,VALUE14.FIELD_VALUE RES_FIELD_VALUE_14
,VALUE15.FIELD_NAME RES_FIELD_NAME_15
,VALUE15.FIELD_VALUE RES_FIELD_VALUE_15
,VALUE16.FIELD_NAME RES_FIELD_NAME_16
,VALUE16.FIELD_VALUE RES_FIELD_VALUE_16
,VALUE17.FIELD_NAME RES_FIELD_NAME_17
,VALUE17.FIELD_VALUE RES_FIELD_VALUE_17
,VALUE18.FIELD_NAME RES_FIELD_NAME_18
,VALUE18.FIELD_VALUE RES_FIELD_VALUE_18
,VALUE19.FIELD_NAME RES_FIELD_NAME_19
,VALUE19.FIELD_VALUE RES_FIELD_VALUE_19
,VALUE20.FIELD_NAME RES_FIELD_NAME_20
,VALUE20.FIELD_VALUE RES_FIELD_VALUE_20

,perJOBEXTRAEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,perJOBEXTRAEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,perJOBEXTRAEO.CREATED_BY RSC_CREATED_BY
,perJOBEXTRAEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_JOBS_F_VL JobDEO
,PER_JOB_EXTRA_INFO_F perJOBEXTRAEO

,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 1) VALUE1
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 2) VALUE2
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 3) VALUE3
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 4) VALUE4
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 5) VALUE5
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 6) VALUE6
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 7) VALUE7
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 8) VALUE8
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 9) VALUE9
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 10) VALUE10
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 11) VALUE11
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 12) VALUE12
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 13) VALUE13
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 14) VALUE14
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 15) VALUE15
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 16) VALUE16
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 17) VALUE17
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 18) VALUE18
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 19) VALUE19
,(SELECT * FROM STRUCTURE_WT_DATA WHERE R1 = 20) VALUE20

WHERE JobDEO.JOB_ID = perJOBEXTRAEO.JOB_ID
AND perJOBEXTRAEO.EFFECTIVE_START_DATE BETWEEN JobDEO.EFFECTIVE_START_DATE AND JobDEO.EFFECTIVE_END_DATE

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE1.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE1.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE2.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE2.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE3.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE3.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE4.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE4.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE5.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE5.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE6.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE6.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE7.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE7.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE8.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE8.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE9.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE9.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE10.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE10.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE11.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE11.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE12.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE12.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE13.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE13.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE14.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE14.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE15.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE15.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE16.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE16.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE17.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE17.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE18.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE18.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE19.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE19.EFFECTIVE_START_DATE(+)

AND perJOBEXTRAEO.JOB_EXTRA_INFO_ID = VALUE20.JOB_EXTRA_INFO_ID(+)
AND perJOBEXTRAEO.EFFECTIVE_START_DATE = VALUE20.EFFECTIVE_START_DATE(+)

ORDER BY JobDEO.name 
,JobDEO.JOB_CODE
,JobDEO.EFFECTIVE_START_DATE
,perJOBEXTRAEO.JEI_INFORMATION_CATEGORY
,perJOBEXTRAEO.SEQUENCE_NUMBER