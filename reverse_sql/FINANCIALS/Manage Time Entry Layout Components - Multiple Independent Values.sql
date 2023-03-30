/* ****************************************************************************
 * $Revision: 59704 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-11-22 17:48:05 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19.01/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20Types%20-%20Tax%20Reporting%20Types.sql $:
 * $Id: Manage Tax Reporting Types - Tax Reporting Types.sql 59704 2016-11-22 10:48:05Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT layoutCompsE0.NAME RES_NAME
,dependentsE0.NAME RES_DEPENDENT_FIELD_NAME
,(CASE
	WHEN ds.IMPLEMENTATION_TYPE = 'VIEW_OBJECT' THEN
		(CASE
			WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.batchProcesses.interfaces.time.publicView.TimeTypeMappingsPVO'
				OR ds.EXECUTABLE_CODE = 'oracle.apps.hcm.batchProcesses.interfaces.time.publicView.TimeTypeValuePVO' THEN
				SUBSTR(independentValuesE0.TCLAYFLD_VALUE,INSTR(independentValuesE0.TCLAYFLD_VALUE,'_',1,1)+1,LENGTH(independentValuesE0.TCLAYFLD_VALUE))
				||' '||(SELECT NAME 
					FROM PER_LEGISLATIVE_DATA_GROUPS_VL 
					WHERE LEGISLATIVE_DATA_GROUP_ID = SUBSTR(independentValuesE0.TCLAYFLD_VALUE,1,INSTR(independentValuesE0.TCLAYFLD_VALUE,'_',1,1)-1))
			WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.globalAbsences.typesSetup.publicView.AbsenceTypesPVO' THEN
				(SELECT NAME
					FROM ANC_ABSENCE_TYPES_F_TL
					WHERE LANGUAGE = USERENV('LANG')
					AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
					AND ABSENCE_TYPE_ID = independentValuesE0.TCLAYFLD_VALUE)
			WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.globalAbsences.plansSetup.publicView.AbsencePlansWfmPVO' THEN
				(SELECT NAME
					FROM ANC_ABSENCE_PLANS_F_TL
					WHERE LANGUAGE = USERENV('LANG')
					AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
					AND ABSENCE_PLAN_ID  = independentValuesE0.TCLAYFLD_VALUE)
			WHEN ds.EXECUTABLE_CODE = 'oracle.apps.hcm.locUS.payrollSetup.details.publicView.UsStatePVO' 
				OR ds.EXECUTABLE_CODE = 'oracle.apps.hcm.locUS.payrollSetup.details.publicView.UsCityPVO' 
				OR ds.EXECUTABLE_CODE = 'oracle.apps.hcm.locUS.payrollSetup.details.publicView.UsCountyPVO'
				OR ds.EXECUTABLE_CODE = 'oracle.apps.hcm.common.core.publicModel.view.HrLookupVO'
				OR ds.EXECUTABLE_CODE = 'oracle.apps.hcm.setupTemplates.core.publicView.ExpeditePrinterPVO'
				OR ds.EXECUTABLE_CODE = 'oracle.apps.hcm.setupTemplates.core.publicView.ExpeditePVO' THEN
				(SELECT ALT_NAME_VALUE
					FROM HWM_TE_ALT_NAME_VALS_VL
					WHERE TE_ALT_NAME_VAL_ID = independentValuesE0.TCLAYFLD_VALUE)
			ELSE
				independentValuesE0.TCLAYFLD_VALUE
			END)
	WHEN ds.IMPLEMENTATION_TYPE = 'TABLE_VALUE_SET' THEN
		ds.EXECUTABLE_CODE||'###R4C###'||independentValuesE0.TCLAYFLD_VALUE
	WHEN ds.IMPLEMENTATION_TYPE = 'FORMAT_VALUE_SET' THEN
		(SELECT ALT_NAME_VALUE
			FROM HWM_TE_ALT_NAME_VALS_VL
			WHERE TE_ALT_NAME_VAL_ID = independentValuesE0.TCLAYFLD_VALUE)
		--independentValuesE0.TCLAYFLD_VALUE
	WHEN ds.IMPLEMENTATION_TYPE = 'INDEPENDENT_VALUE_SET' THEN
		(SELECT ALT_NAME_VALUE
			FROM HWM_TE_ALT_NAME_VALS_VL
			WHERE TE_ALT_NAME_VAL_ID = independentValuesE0.TCLAYFLD_VALUE)
		--independentValuesE0.TCLAYFLD_VALUE
	END) RES_INDEPENDENT_TIME_ATTRIBUTE
,independentValuesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,independentValuesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,independentValuesE0.CREATED_BY RSC_CREATED_BY
,independentValuesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HXT_TCLAYFLD_DEFNS_VL layoutCompsE0
,(SELECT * FROM HXT_TCLAYFLD_DEFNS_VL WHERE TCLAY_ID IS NULL) dependentsE0
,HXT_TCLAYFLD_CXT_DEPT independentValuesE0
,(SELECT dsE0.EXECUTABLE_CODE
	,dsUsage.DATA_SOURCE_USAGE_ID
	,dsE0.IMPLEMENTATION_TYPE
    FROM HWM_DATA_SOURCE_USAGES dsUsage
    ,HWM_DATA_SOURCES_VL dsE0
    WHERE dsE0.DATA_SOURCE_ID = dsUsage.DATA_SOURCE_ID
	AND dsUsage.DEFAULT_FLAG = 'Y'
	) ds
WHERE layoutCompsE0.TCLAY_ID IS NULL
AND layoutCompsE0.TCLAYFLD_DEFNS_ID = dependentsE0.P_TCLAYFLD_DEFNS_ID
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR1 = 'M'
AND dependentsE0.TCLAYFLD_DEFNS_ID = independentValuesE0.TCLAYFLD_DEFNS_ID
AND dependentsE0.TCLAYFLD_ATTRIBUTE_NUMBER2 = ds.DATA_SOURCE_USAGE_ID
ORDER BY layoutCompsE0.NAME