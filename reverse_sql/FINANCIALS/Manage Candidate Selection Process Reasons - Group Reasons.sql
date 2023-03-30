/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=IRC_LC_REASON_GROUPS_VL
--RSC_PREREQUISITE_OBJECTS=IRC_LC_REASON_USAGES
--RSC_PREREQUISITE_OBJECTS=IRC_LC_REASONS_VL

SELECT reasonGroupsE0.REASON_GROUP_NAME RES_NAME
,reasonGroupsE0.REASON_GROUP_CODE RES_CODE
,reasonGroupsE0.REASON_GROUP_COMMENTS RES_DESCRIPTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_REASON_GROUP_STATUS'
    AND LOOKUP_CODE = reasonGroupsE0.REASON_GROUP_STATUS_CODE
    ) RES_STATUS
,reasonsE0.REASON_NAME RES_REASON_NAME
,reasonsE0.REASON_CODE RES_REASON_CODE

,reasonUsagesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,reasonUsagesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,reasonUsagesE0.CREATED_BY  RSC_CREATED_BY
,reasonUsagesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM IRC_LC_REASON_GROUPS_VL reasonGroupsE0
,IRC_LC_REASON_USAGES reasonUsagesE0
,IRC_LC_REASONS_VL reasonsE0
WHERE reasonGroupsE0.REASON_GROUP_ID = reasonUsagesE0.REASON_GROUP_ID
AND reasonUsagesE0.REASON_ID = reasonsE0.REASON_ID
ORDER BY reasonGroupsE0.REASON_GROUP_NAME
,reasonsE0.REASON_NAME
