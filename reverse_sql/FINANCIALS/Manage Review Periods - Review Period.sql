/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Review%20Periods%20-%20Review%20Period.sql $:
 * $Id: Manage Review Periods - Review Period.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=HRT_REVIEW_PERIODS_VL
 
SELECT hrtREVIEWPEREO.REVIEW_PERIOD_NAME RES_REVIEW_PERIOD_NAME
,hrtREVIEWPEREO.DESCRIPTION RES_DESCRIPTION
,DECODE(hrtREVIEWPEREO.STATUS_CODE,'A','Active','I','Inactive') RES_STATUS
,TO_CHAR(hrtREVIEWPEREO.START_DATE,'DD-Mon-YYYY') RES_PERIOD_START_DATE
,TO_CHAR(hrtREVIEWPEREO.END_DATE,'DD-Mon-YYYY') RES_PERIOD_END_DATE
,hrtREVIEWPEREO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hrtREVIEWPEREO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hrtREVIEWPEREO.CREATED_BY RSC_CREATED_BY
,hrtREVIEWPEREO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_REVIEW_PERIODS_VL hrtREVIEWPEREO
ORDER BY RES_REVIEW_PERIOD_NAME
