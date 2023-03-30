/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT 
(SELECT ORGANIZATION_CODE 
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = InvAbcClasses.ORGANIZATION_ID)RES_ORGANIZATION
,InvAbcClasses.ABC_CLASS_NAME RES_ABC_CLASS
,InvAbcClasses.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(InvAbcClasses.ENABLE_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(InvAbcClasses.DISABLE_DATE,'DD-Mon-YYYY') RES_END_DATE
,InvAbcClasses.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,InvAbcClasses.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,InvAbcClasses.CREATED_BY RSC_CREATED_BY
,InvAbcClasses.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,InvAbcClasses.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_ABC_CLASSES InvAbcClasses
ORDER BY 1,2