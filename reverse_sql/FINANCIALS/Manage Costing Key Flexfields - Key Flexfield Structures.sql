/* ****************************************************************************
* $Revision: 55265 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2016-05-17 14:17:07 +0700 (Tue, 17 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Key%20Flexfields%20-%20Manage%20Key%20Flexfield%20Structures.sql $:
* $Id: Manage Fixed Assets Key Flexfields - Manage Key Flexfield Structures.sql 55265 2016-05-17 07:17:07Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE AS RES_KEY_FLEXFIELD_CODE
,FndKfFlexfieldVl.NAME AS RES_KEY_FLEXFIELD_NAME
,KeyFlexfieldStructureEO.STRUCTURE_CODE AS RES_STRUCTURE_CODE
,KeyFlexfieldStructureEO.NAME AS RES_NAME
,KeyFlexfieldStructureEO.DESCRIPTION AS RES_DESCRIPTION
,KeyFlexfieldStructureEO.DELIMITER AS RES_DELIMITER
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = KeyFlexfieldStructureEO.ENABLED_FLAG
	) AS RES_ENABLED
,KeyFlexfieldStructureEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,KeyFlexfieldStructureEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,KeyFlexfieldStructureEO.CREATED_BY RSC_CREATED_BY
,KeyFlexfieldStructureEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_KF_FLEXFIELDS_VL FndKfFlexfieldVl
,FND_KF_STRUCTURES_VL KeyFlexfieldStructureEO
WHERE FndKfFlexfieldVl.KEY_FLEXFIELD_CODE = KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE
AND FndKfFlexfieldVl.KEY_FLEXFIELD_CODE IN (
	SELECT AskBoAttributeValues.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES AskBoAttributeValues
	,ASK_TASKS_VL AskTasksVl
	WHERE AskBoAttributeValues.TASK_ID = AskTasksVl.TASK_ID
	AND AskTasksVl.TASK_SHORT_NAME = 'CST_MANAGE_COSTING_KEY_FLEXFIELDS')
ORDER BY KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE
,FndKfFlexfieldVl.NAME 
,KeyFlexfieldStructureEO.STRUCTURE_CODE
,KeyFlexfieldStructureEO.NAME 