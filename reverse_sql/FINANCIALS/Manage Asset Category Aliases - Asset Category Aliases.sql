/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Categories%20-%20Asset%20Category.sql $:
* $Id: Manage Asset Categories - Asset Category.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=FA_CATEGORY_ALIASES_VL

-- syntax: APPLICATION_ID##RES##KFF_CODE
-- KFF_LOGIC_TO_APPLY=140##RES##CAT#
-- KFF_PREFIX_ALIAS=RES_CATEGORY
-- KFF_COLUMN_NAME=SEGMENT


SELECT FaCategoryB.NAME 	 RES_NAME
, FaCategoryB.SEGMENT1  	 RES_CATEGORY1
, FaCategoryB.SEGMENT2       RES_CATEGORY2
, FaCategoryB.SEGMENT3       RES_CATEGORY3
, FaCategoryB.SEGMENT4       RES_CATEGORY4
, FaCategoryB.SEGMENT5       RES_CATEGORY5
, FaCategoryB.SEGMENT6       RES_CATEGORY6
, FaCategoryB.SEGMENT7       RES_CATEGORY7
, FaCategoryB.DESCRIPTION RES_DESCRIPTION
, DECODE(FaCategoryB.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
, TO_CHAR(FaCategoryB.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
, TO_CHAR(FaCategoryB.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE

,FaCategoryB.STRUCTURE_INSTANCE_NUMBER RSC_EXTRA_COLUMN1
,FaCategoryB.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,FaCategoryB.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,FaCategoryB.CREATED_BY RSC_CREATED_BY
,FaCategoryB.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_CATEGORY_ALIASES_VL FaCategoryB
ORDER BY FaCategoryB.NAME