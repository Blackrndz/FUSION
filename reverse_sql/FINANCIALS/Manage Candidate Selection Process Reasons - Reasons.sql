/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=IRC_LC_REASONS_VL

SELECT reasonsE0.REASON_NAME RES_NAME
,reasonsE0.REASON_CODE RES_CODE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_REASON_STATUS'
    AND LOOKUP_CODE = reasonsE0.REASON_STATUS_CODE
    ) RES_STATUS
 
,reasonsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,reasonsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,reasonsE0.CREATED_BY  RSC_CREATED_BY
,reasonsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM IRC_LC_REASONS_VL reasonsE0
ORDER BY reasonsE0.REASON_NAME
