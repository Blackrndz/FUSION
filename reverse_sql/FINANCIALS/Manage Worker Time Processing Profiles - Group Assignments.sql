/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Worker%20Time%20Processing%20Profiles%20-%20Group%20Assignments.sql $:
* $Id: Manage Worker Time Processing Profiles - Group Assignments.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT  hxtSPEO.NAME RES_PROFILE_NAME 
,hwmGVEO.GROUP_NAME RES_GROUP_NAME
,TO_CHAR(hxtSPAEO.DATE_FROM,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(hxtSPAEO.DATE_TO,'DD-Mon-YYYY') RES_TO_DATE

,hxtSPAEO.CREATED_BY  AS RSC_CREATED_BY
,hxtSPAEO.CREATION_DATE AS RSC_CREATION_DATE
,hxtSPAEO.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,hxtSPAEO.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
  

FROM HXT_SETUP_PROFILES_VL hxtSPEO 
,HXT_SETUP_PROFILE_ASGS hxtSPAEO
,HWM_GRPS_VL hwmGVEO
WHERE hxtSPEO.PRODUCT_AREA = 'CORE' 
AND hxtSPEO.SETUP_PROFILE_ID = hxtSPAEO.SETUP_PROFILE_ID
AND hxtSPAEO.OBJECT_ID = hwmGVEO.GRP_ID
ORDER BY hxtSPEO.PRECEDENCE
