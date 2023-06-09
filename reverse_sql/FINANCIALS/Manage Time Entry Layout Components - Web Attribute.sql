/* ****************************************************************************
 * $Revision: 59704 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-11-22 17:48:05 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19.01/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20Types%20-%20Tax%20Reporting%20Types.sql $:
 * $Id: Manage Tax Reporting Types - Tax Reporting Types.sql 59704 2016-11-22 10:48:05Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=HWM_TE_ALT_NAME_VALS_VL
-- VALUE_SET_LOGIC_TO_APPLY_FIELDS=RES_IN,RES_OUT
 
WITH ATTR AS (SELECT 1 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE1 VAL
	,ADDL_ATTRIBUTE1 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 2 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE2 VAL
	,ADDL_ATTRIBUTE2 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 3 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE3 VAL
	,ADDL_ATTRIBUTE3 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 4 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE4 VAL
	,ADDL_ATTRIBUTE4 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 5 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE5 VAL
	,ADDL_ATTRIBUTE5 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 6 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE6 VAL
	,ADDL_ATTRIBUTE6 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 7 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE7 VAL
	,ADDL_ATTRIBUTE7 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 8 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE8 VAL
	,ADDL_ATTRIBUTE8 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 9 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE9 VAL
	,ADDL_ATTRIBUTE9 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 10 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE10 VAL
	,ADDL_ATTRIBUTE10 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 11 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE11 VAL
	,ADDL_ATTRIBUTE11 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 12 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE12 VAL
	,ADDL_ATTRIBUTE12 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 13 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE13 VAL
	,ADDL_ATTRIBUTE13 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 14 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE14 VAL
	,ADDL_ATTRIBUTE14 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 15 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE15 VAL
	,ADDL_ATTRIBUTE15 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 16 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE16 VAL
	,ADDL_ATTRIBUTE16 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 17 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE17 VAL
	,ADDL_ATTRIBUTE17 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 18 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE18 VAL
	,ADDL_ATTRIBUTE18 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 19 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE19 VAL
	,ADDL_ATTRIBUTE19 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 20 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE20 VAL
	,ADDL_ATTRIBUTE20 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 21 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE21 VAL
	,ADDL_ATTRIBUTE21 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 22 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE22 VAL
	,ADDL_ATTRIBUTE22 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 23 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE23 VAL
	,ADDL_ATTRIBUTE23 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 24 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE24 VAL
	,ADDL_ATTRIBUTE24 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 25 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE25 VAL
	,ADDL_ATTRIBUTE25 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 26 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE26 VAL
	,ADDL_ATTRIBUTE26 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 27 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE27 VAL
	,ADDL_ATTRIBUTE27 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 28 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE28 VAL
	,ADDL_ATTRIBUTE28 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 29 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE29 VAL
	,ADDL_ATTRIBUTE29 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	
	UNION
	
	SELECT 30 SEQ
	,TE_ALT_NAME_VAL_ID
	,ATTRIBUTE30 VAL
	,ADDL_ATTRIBUTE30 VAL_OUT
	FROM HWM_TE_ALT_NAME_VALS_VL
	)

SELECT RES_NAME
,RES_BUTTON_LABEL
,RES_ATTRIBUTE_DISPLAY_SEQUENCE
,RES_ATTRIBUTE
,RES_IN
,RES_OUT
,RSC_LAST_UPDATED_BY
,RSC_LAST_UPDATE_DATE
,RSC_CREATED_BY
,RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT layoutCompsE0.NAME RES_NAME
	,teNameValsE0.ALT_NAME_VALUE RES_BUTTON_LABEL
	,setCmpsE0.SEQUENCE RES_ATTRIBUTE_DISPLAY_SEQUENCE
	,(SELECT DISPLAY_NAME 
			FROM HWM_TM_ATRB_FLDS_VL 
			WHERE TM_ATRB_FLD_ID = setCmpsE0.TM_ATRB_FLD_ID
			) RES_ATTRIBUTE
	,(CASE
		WHEN ds.IMPLEMENTATION_TYPE = 'VIEW_OBJECT' THEN
			(CASE
				WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.batchProcesses.interfaces.time.publicView.TimeTypeMappingsPVO' THEN
					SUBSTR(attrE0.VAL,INSTR(attrE0.VAL,'_',1,1)+1,LENGTH(attrE0.VAL))
						||' '||(SELECT NAME 
							FROM PER_LEGISLATIVE_DATA_GROUPS_VL 
							WHERE LEGISLATIVE_DATA_GROUP_ID = SUBSTR(attrE0.VAL,1,INSTR(attrE0.VAL,'_',1,1)-1)
							)
				WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.globalAbsences.typesSetup.publicView.AbsenceTypesPVO' THEN
					(SELECT NAME
						FROM ANC_ABSENCE_TYPES_F_TL
						WHERE LANGUAGE = USERENV('LANG')
						AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
						AND ABSENCE_TYPE_ID = attrE0.VAL)
				WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.globalAbsences.plansSetup.publicView.AbsencePlansWfmPVO' THEN
					(SELECT NAME
						FROM ANC_ABSENCE_PLANS_F_TL
						WHERE LANGUAGE = USERENV('LANG')
						AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
						AND ABSENCE_PLAN_ID  = attrE0.VAL)
				ELSE
					attrE0.VAL
				END)
		WHEN ds.IMPLEMENTATION_TYPE = 'TABLE_VALUE_SET' THEN
			(CASE
				WHEN attrE0.VAL IS NOT NULL THEN
					ds.EXECUTABLE_CODE||'###R4C###'||attrE0.VAL
				END)
		WHEN ds.IMPLEMENTATION_TYPE = 'FORMAT_VALUE_SET' THEN
			attrE0.VAL 
		WHEN ds.IMPLEMENTATION_TYPE = 'INDEPENDENT_VALUE_SET' THEN
			attrE0.VAL
		END) RES_IN
	,(CASE
		WHEN ds.IMPLEMENTATION_TYPE = 'VIEW_OBJECT' THEN
			(CASE
				WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.batchProcesses.interfaces.time.publicView.TimeTypeMappingsPVO' THEN
					SUBSTR(attrE0.VAL_OUT,INSTR(attrE0.VAL_OUT,'_',1,1)+1,LENGTH(attrE0.VAL_OUT))
						||' '||(SELECT NAME 
							FROM PER_LEGISLATIVE_DATA_GROUPS_VL 
							WHERE LEGISLATIVE_DATA_GROUP_ID = SUBSTR(attrE0.VAL_OUT,1,INSTR(attrE0.VAL_OUT,'_',1,1)-1)
							)
				WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.globalAbsences.typesSetup.publicView.AbsenceTypesPVO' THEN
					(SELECT NAME
						FROM ANC_ABSENCE_TYPES_F_TL
						WHERE LANGUAGE = USERENV('LANG')
						AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
						AND ABSENCE_TYPE_ID = attrE0.VAL_OUT)
				WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.globalAbsences.plansSetup.publicView.AbsencePlansWfmPVO' THEN
					(SELECT NAME
						FROM ANC_ABSENCE_PLANS_F_TL
						WHERE LANGUAGE = USERENV('LANG')
						AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
						AND ABSENCE_PLAN_ID  = attrE0.VAL_OUT)
				ELSE
					attrE0.VAL_OUT
				END)
		WHEN ds.IMPLEMENTATION_TYPE = 'TABLE_VALUE_SET' THEN
			(CASE
				WHEN attrE0.VAL_OUT IS NOT NULL THEN
					ds.EXECUTABLE_CODE||'###R4C###'||attrE0.VAL_OUT
				END)
		WHEN ds.IMPLEMENTATION_TYPE = 'FORMAT_VALUE_SET' THEN
			attrE0.VAL_OUT 
		WHEN ds.IMPLEMENTATION_TYPE = 'INDEPENDENT_VALUE_SET' THEN
			attrE0.VAL_OUT
		END) RES_OUT
	,teNameValsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
	,teNameValsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
	,teNameValsE0.CREATED_BY RSC_CREATED_BY
	,teNameValsE0.CREATION_DATE RSC_CREATION_DATE
	,setCmpsE0.SEQUENCE SEQ
	FROM HXT_TCLAYFLD_DEFNS_VL layoutCompsE0
	,HWM_TE_ALT_NAMES teNamesE0
	,HWM_TM_ATRB_FLD_SET_CMPS setCmpsE0
	,HWM_TE_ALT_NAME_VALS_VL teNameValsE0
	,ATTR attrE0
	,(SELECT dsE0.EXECUTABLE_CODE
		,dsUsage.DATA_SOURCE_USAGE_ID
		,dsE0.IMPLEMENTATION_TYPE
		FROM HWM_DATA_SOURCE_USAGES dsUsage
		,HWM_DATA_SOURCES_VL dsE0
		WHERE dsE0.DATA_SOURCE_ID = dsUsage.DATA_SOURCE_ID
		AND dsUsage.DEFAULT_FLAG = 'Y'
		) ds
	WHERE layoutCompsE0.TCLAY_ID IS NULL
	AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR1 = 'W'
	AND layoutCompsE0.P_TCLAYFLD_DEFNS_ID IS NULL
	AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_NUMBER1 = teNamesE0.TE_ALT_NAME_ID
	AND teNamesE0.TM_ATRB_FLD_SET_ID = setCmpsE0.TM_ATRB_FLD_SET_ID
	AND teNamesE0.TE_ALT_NAME_ID = teNameValsE0.TE_ALT_NAME_ID
	AND teNameValsE0.TE_ALT_NAME_VAL_ID = attrE0.TE_ALT_NAME_VAL_ID
	AND setCmpsE0.SEQUENCE = attrE0.SEQ
	AND setCmpsE0.DATA_SOURCE_USAGE_ID = ds.DATA_SOURCE_USAGE_ID
	)
WHERE TRIM(RES_IN) IS NOT NULL OR TRIM(RES_OUT) IS NOT NULL
ORDER BY RES_NAME
,RSC_CREATION_DATE
,SEQ