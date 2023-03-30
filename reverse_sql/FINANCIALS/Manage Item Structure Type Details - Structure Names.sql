/* ****************************************************************************
* $Revision: 61485 $:
* $Author: chanatip.buabhom $:
* $Date: 2017-03-21 17:10:25 +0700 (Tue, 21 Mar 2017) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Expense%20Fields%20by%20Category%20-%20Airfare.sql $:
* $Id: Manage Expense Fields by Category - Airfare.sql 61485 2017-03-21 10:10:25Z chanatip.buabhom $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT EgpStructureTypesE0.DISPLAY_NAME RES_DISPLAY_NAME
,EgpStructureNamesE0.DISPLAY_NAME RES_STRUCTURE_DISPLAY_NAME
,EgpStructureNamesE0.ALTERNATE_DESIGNATOR_CODE RES_STRUCTURE_INTERNAL_NAME
,EgpStructureNamesE0.DESCRIPTION RES_DESCRIPTION
,DECODE(EgpStructureNamesE0.LIFECYCLE_VALIDATION_FLAG,1,'Yes','No') RES_ENABLE_LIFECYCLE_VALIDATIO
,DECODE(EgpStructureNamesE0.USE_PRIMARY_FOR_EXPL_FLAG,'Y','Yes','No') RES_USE_PRIMARY_FOR_EXPANSION
,TO_CHAR(EgpStructureNamesE0.EFFECTIVE_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_START_DATE
,TO_CHAR(EgpStructureNamesE0.DISABLE_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_END_DATE
,EgpStructureNamesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,EgpStructureNamesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,EgpStructureNamesE0.CREATED_BY RSC_CREATED_BY
,EgpStructureNamesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_STRUCTURE_TYPES_VL EgpStructureTypesE0
,EGP_STRUCTURE_NAMES_VL EgpStructureNamesE0
WHERE EgpStructureTypesE0.STRUCTURE_TYPE_NAME = 'ITM_STR_TYP'
AND EgpStructureTypesE0.LANGUAGE = USERENV('LANG')
AND EgpStructureTypesE0.STRUCTURE_TYPE_ID = EgpStructureNamesE0.STRUCTURE_TYPE_ID
AND EgpStructureNamesE0.LANGUAGE = USERENV('LANG')
ORDER BY EgpStructureTypesE0.DISPLAY_NAME
,EgpStructureNamesE0.DISPLAY_NAME