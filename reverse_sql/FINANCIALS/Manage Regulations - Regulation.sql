/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Regulations%20-%20Regulation.sql $:
 * $Id: Manage Regulations - Regulation.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT benREGNEO.NAME RES_NAME
,TO_CHAR(benREGNEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(benREGNEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,benREGNEO.STTRY_CITN_NAME RES_STATUTORY_CITATION

,benREGNEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,benREGNEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,benREGNEO.CREATED_BY RSC_CREATED_BY
,benREGNEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_REGN_F benREGNEO

WHERE SYSDATE BETWEEN benREGNEO.EFFECTIVE_START_DATE AND NVL(benREGNEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
ORDER BY benREGNEO.NAME DESC