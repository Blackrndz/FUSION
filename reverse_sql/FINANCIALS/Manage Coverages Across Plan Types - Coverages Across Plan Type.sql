/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Coverages%20Across%20Plan%20Types%20-%20Coverages%20Across%20Plan%20Type.sql $:
 * $Id: Manage Coverages Across Plan Types - Coverages Across Plan Type.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT benACRPTIPCVGEO.NAME RES_COVERAGE_LIMIT_NAME

,benACRPTIPCVGEO.LAST_UPDATED_BY 			RSC_LAST_UPDATED_BY
,benACRPTIPCVGEO.LAST_UPDATE_DATE 			RSC_LAST_UPDATE_DATE
,benACRPTIPCVGEO.CREATED_BY 				RSC_CREATED_BY
,benACRPTIPCVGEO.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ACRS_PTIP_CVG_F benACRPTIPCVGEO
WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
