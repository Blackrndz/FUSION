/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT 
(SELECT ITEM_CLASS_NAME
	FROM EGP_ITEM_CLASSES_VL
	WHERE ITEM_CLASS_ID = ItemClassPEO.PARENT_ITEM_CLASS_ID
	) RES_PARENT_ITEM_CLASS 
,ItemClassPEO.ITEM_CLASS_NAME RES_ITEM_CLASS
,PhasesEO.PHASE_SEQ RES_SEQUENCE
,PhasesEO.PHASE_CODE RES_LIFECYCLE_PHASE
,PhasesEO.PHASE_NAME RES_PHASE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGP_LIFECYCLE_PHASES'
	AND LOOKUP_CODE = PhasesEO.PHASE_TYPE
	) RES_PHASE_TYPE
,TO_CHAR(PhasesEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(PhasesEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,ItemClassPEO.ITEM_CLASS_NAME RES_LIFECYCLE_PHASES_ITEM_CLAS
,ItemClassPhasesEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ItemClassPhasesEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ItemClassPhasesEO.CREATED_BY RSC_CREATED_BY
,ItemClassPhasesEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_CLASSES_VL ItemClassPEO
,EGP_ITEMCLASS_PHASES ItemClassPhasesEO
,EGP_PHASES_VL PhasesEO
WHERE ItemClassPEO.ITEM_CLASS_ID = ItemClassPhasesEO.CATEGORY_ID
AND ItemClassPhasesEO.PHASE_CODE = PhasesEO.PHASE_CODE
CONNECT BY ItemClassPEO.PARENT_ITEM_CLASS_ID = ItemClassPEO.ITEM_CLASS_ID
ORDER SIBLINGS BY RES_PARENT_ITEM_CLASS,RES_ITEM_CLASS