/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Derived%20Factors%20-%20Age%20and%20Service.sql $:
 * $Id: Manage Derived Factors - Age and Service.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT benCMBNFACEO.NAME RES_NAME
,(SELECT NAME FROM BEN_AGE_FCTR WHERE AGE_FCTR_ID = benCMBNFACEO.AGE_FCTR_ID) RES_AGE_FACTOR
,(SELECT NAME FROM BEN_LOS_FCTR WHERE LOS_FCTR_ID = benCMBNFACEO.LOS_FCTR_ID) RES_LENGTH_OF_SERVICE_FACTOR
,benCMBNFACEO.CMBND_MIN_VAL RES_GREATER_THAN_OR_EQUAL_TO_A
,benCMBNFACEO.CMBND_MAX_VAL RES_LESS_THAN_AGE_AND_SERVICE

,benCMBNFACEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,benCMBNFACEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,benCMBNFACEO.CREATED_BY RSC_CREATED_BY
,benCMBNFACEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,benCMBNFACEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_CMBN_AGE_LOS_FCTR benCMBNFACEO
ORDER BY benCMBNFACEO.NAME
