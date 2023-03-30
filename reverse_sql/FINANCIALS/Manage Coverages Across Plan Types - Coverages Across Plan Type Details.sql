/* ****************************************************************************
 * $Revision: 72971 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-12-02 11:14:08 +0700 (Mon, 02 Dec 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Coverages%20Across%20Plan%20Types%20-%20Coverages%20Across%20Plan%20Type.sql $:
 * $Id: Manage Coverages Across Plan Types - Coverages Across Plan Type.sql 72971 2019-12-02 04:14:08Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT  TO_CHAR(benACRPTIPCVGEO.EFFECTIVE_START_DATE,'DD-MM-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(benACRPTIPCVGEO.EFFECTIVE_END_DATE,'DD-MM-YYYY') RES_EFFECTIVE_END_DATE
,benACRPTIPCVGEO.NAME RES_COVERAGE_LIMIT_NAME
,(SELECT NAME FROM BEN_PGM_F WHERE PGM_ID = benACRPTIPCVGEO.PGM_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_PROGRAM_NAME
,TO_CHAR(benACRPTIPCVGEO.MN_CVG_ALWD_AMT,'9999') RES_MINIMUM
,TO_CHAR(benACRPTIPCVGEO.MX_CVG_ALWD_AMT,'9999') RES_MAXIMUM



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