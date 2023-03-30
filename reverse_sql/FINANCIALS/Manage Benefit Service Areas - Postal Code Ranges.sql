/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Service%20Areas%20-%20Postal%20Code%20Ranges.sql $:
 * $Id: Manage Benefit Service Areas - Postal Code Ranges.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT  /*TO_CHAR(benPSTLZIPRNGEO.FROM_VALUE,'999') RES_FROM_VALUE
,TO_CHAR(benPSTLZIPRNGEO.TO_VALUE,'999') RES_TO_VALUE*/
benPSTLZIPRNGEO.FROM_VALUE RES_FROM_VALUE
,benPSTLZIPRNGEO.TO_VALUE RES_TO_VALUE
,TO_CHAR(benPSTLZIPRNGEO.START_DATE,'DD-MM-YYYY') RES_START_DATE
,TO_CHAR(benPSTLZIPRNGEO.END_DATE,'DD-MM-YYYY') RES_END_DATE


,benPSTLZIPRNGEO.LAST_UPDATED_BY 			RSC_LAST_UPDATED_BY
,benPSTLZIPRNGEO.LAST_UPDATE_DATE 			RSC_LAST_UPDATE_DATE
,benPSTLZIPRNGEO.CREATED_BY 				RSC_CREATED_BY
,benPSTLZIPRNGEO.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_PSTL_ZIP_RNG benPSTLZIPRNGEO
WHERE SYSDATE BETWEEN benPSTLZIPRNGEO.START_DATE AND NVL(benPSTLZIPRNGEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
