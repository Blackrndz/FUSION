/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL

SELECT geoHierarchiesE0.NAME RES_NAME
,TO_CHAR(geoHierarchiesE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,'' RES_START_ON_ACTIVATION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_GEO_HIER_VERS_STATUS'
    AND LOOKUP_CODE =geoHierarchiesE0.STATUS_CODE
    ) RES_STATUS
,geoHierarchiesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,geoHierarchiesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,geoHierarchiesE0.CREATED_BY  RSC_CREATED_BY
,geoHierarchiesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_GEO_HIERARCHIES geoHierarchiesE0
ORDER BY geoHierarchiesE0.NAME