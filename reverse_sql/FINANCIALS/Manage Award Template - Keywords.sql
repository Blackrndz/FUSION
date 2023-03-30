/* ****************************************************************************
 * $Revision: 74208 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-06-03 19:08:12 +0700 (Wed, 03 Jun 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/branches/core/v2.2.3.0.B/reverse_sql/FINANCIALS/Manage%20AutoPost%20Criteria%20Sets%20-%20AutoPost%20Criteria.sql $:
 * $Id: Manage AutoPost Criteria Sets - AutoPost Criteria.sql 74208 2020-06-03 12:08:12Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT gmsAWARDTEMPE0.TEMPLATE_NAME RES_TEMPLATE_NAME
,gmsAWARDTEMPE0.TEMPLATE_NUMBER RES_TEMPLATE_NUMBER
,gmsKEYE0.KEYWORD_NAME RES_NAME
,gmsKEYE0.DESCRIPTION RES_DESCRIPTION

,gmsAWARDKEYE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,gmsAWARDKEYE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,gmsAWARDKEYE0.CREATED_BY RSC_CREATED_BY
,gmsAWARDKEYE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GMS_AWARD_TEMPLATES_VL gmsAWARDTEMPE0
,GMS_AWARD_HEADERS_B gmsAWARDHEABE0
,GMS_AWARD_KEYWORDS gmsAWARDKEYE0
,GMS_KEYWORDS_VL gmsKEYE0
WHERE gmsAWARDTEMPE0.AWARD_HEADER_ID = gmsAWARDHEABE0.ID
AND gmsAWARDHEABE0.ID = gmsAWARDKEYE0.AWARD_ID
AND gmsAWARDKEYE0.KEYWORD = gmsKEYE0.KEYWORD_ID
AND SYSDATE BETWEEN gmsKEYE0.START_DATE_ACTIVE AND NVL(gmsKEYE0.END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY gmsAWARDTEMPE0.TEMPLATE_NAME