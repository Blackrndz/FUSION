/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=IRC_DIMENSION_DEF_VL

SELECT ircDIMENE0.SOURCE_URL_VALUE RES_SOURCEURLVALUE 
,ircDIMENE0.SOURCE_NAME RES_SOURCE_NAME
,ircDIMENE0.SEQUENCE RES_DISPLAY_SEQUENCE

,ircDIMENE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ircDIMENE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ircDIMENE0.CREATED_BY  RSC_CREATED_BY
,ircDIMENE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM IRC_DIMENSION_DEF_VL ircDIMENE0
WHERE ircDIMENE0.SOURCE_MEDIUM = 'ORA_DIRECTSOURCE'
ORDER BY ircDIMENE0.SEQUENCE 