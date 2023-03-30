/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Default%20Item%20Class%20-%20Lifecycle%20Phases.sql $:
 * $Id: Manage Default Item Class - Lifecycle Phases.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT ItemClassPEO.ITEM_CLASS_CODE RES_INTERNAL_NAME
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
,ItemClassPEO.ITEM_CLASS_NAME RES_ITEM_CLASS
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
WHERE ItemClassPEO.PARENT_ITEM_CLASS_ID NOT IN (SELECT ITEM_CLASS_ID FROM EGP_ITEM_CLASSES_VL)
AND ItemClassPEO.ITEM_CLASS_ID = ItemClassPhasesEO.CATEGORY_ID
AND ItemClassPhasesEO.PHASE_CODE = PhasesEO.PHASE_CODE
ORDER BY ItemClassPEO.ITEM_CLASS_CODE
,PhasesEO.PHASE_SEQ