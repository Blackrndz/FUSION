/* ****************************************************************************
 * $Revision: 66952 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2018-02-26 16:15:13 +0700 (Mon, 26 Feb 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Assign%20Business%20Unit%20Business%20Function%20-%20Assign%20Business%20Functions.sql $:
 * $Id: Assign Business Unit Business Function - Assign Business Functions.sql 66952 2018-02-26 09:15:13Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select distinct Head.NAME RES_BUSINESS_UNIT_NAME
,BusinessFunctionPEO.BUSINESS_FUNCTION_NAME RES_FUNCTION_NAME
,decode(BusinessUnitUsageEO.CONFIGURATION_STATUS,'Y','Yes','No') RES_ENABLED
,Head.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,Head.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,Head.CREATED_BY  RSC_CREATED_BY
,Head.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,Head.ORGANIZATION_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,Head.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT
	BusinessUnitEO.NAME,
	XleEntityProfiles.NAME AS NAME1,
	GlLedgers.NAME AS NAME2,
	BusinessUnitDetailEO.ORG_INFORMATION9,
	BusinessUnitEO.ORGANIZATION_ID  ,
	BusinessUnitDetailEO.BUSINESS_GROUP_ID,
	BusinessUnitDetailEO.LAST_UPDATED_BY ,
	BusinessUnitDetailEO.LAST_UPDATE_DATE,
	BusinessUnitDetailEO.CREATED_BY ,
	BusinessUnitDetailEO.CREATION_DATE
	FROM Fusion.HR_ORGANIZATION_V BusinessUnitEO, 
	Fusion.HR_ORG_DETAILS_BY_CLASS_V BusinessUnitDetailEO, 
	Fusion.XLE_ENTITY_PROFILES XleEntityProfiles, 
	Fusion.GL_LEDGERS GlLedgers
	WHERE (BusinessUnitEO.ORGANIZATION_ID            = BusinessUnitDetailEO.ORGANIZATION_ID)
	AND (BusinessUnitEO.CLASSIFICATION_CODE          = BusinessUnitDetailEO.CLASSIFICATION_CODE)
	AND BusinessUnitDetailEO.ORG_INFORMATION_CONTEXT = BusinessUnitEO.CLASSIFICATION_CODE
	AND BusinessUnitEO.CLASSIFICATION_CODE           = 'FUN_BUSINESS_UNIT'
	AND (BusinessUnitDetailEO.ORG_INFORMATION2       = XleEntityProfiles.LEGAL_ENTITY_ID(+))
	AND (BusinessUnitDetailEO.ORG_INFORMATION3       = GlLedgers.LEDGER_ID(+))
	) Head
,Fusion.FUN_BU_USAGES BusinessUnitUsageEO
,Fusion.FUN_BUSINESS_FUNCTIONS_VL BusinessFunctionPEO 
Where BusinessUnitUsageEO.BUSINESS_UNIT_ID = Head.ORGANIZATION_ID(+)
AND BusinessFunctionPEO.BUSINESS_FUNCTION_ID = BusinessUnitUsageEO.MODULE_ID(+)
order by Head.NAME
,BusinessFunctionPEO.BUSINESS_FUNCTION_NAME 