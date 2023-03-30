/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Worker%20Time%20Entry%20Profiles%20-%20Profile%20Values.sql $:
* $Id: Manage Worker Time Entry Profiles - Profile Values.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT hxtSPEO.NAME RES_PROFILE_NAME 
,hxtSOVEO.CREATED_BY  AS RSC_CREATED_BY
,hxtSOVEO.CREATION_DATE AS RSC_CREATION_DATE
,hxtSOVEO.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,hxtSOVEO.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
  

FROM HXT_SETUP_PROFILES_VL hxtSPEO 
,HXT_SETUP_OPTION_VALS hxtSOVEO
,HXT_TCLAYST_VL hxtTCALYEO
WHERE hxtSPEO.PRODUCT_AREA = 'WORKER_TIMECARD' 
AND hxtSPEO.SETUP_PROFILE_ID = hxtSOVEO.SETUP_PROFILE_ID
AND hxtSOVEO.VALUE30 = hxtTCALYEO.TCLAYST_ID
AND hxtSOVEO.TYPE = 'WORKER'
AND SYSDATE BETWEEN hxtSOVEO.EFFECTIVE_START_DATE AND hxtSOVEO.EFFECTIVE_END_DATE
ORDER BY hxtSPEO.PRECEDENCE,hxtSOVEO.EFFECTIVE_START_DATE
