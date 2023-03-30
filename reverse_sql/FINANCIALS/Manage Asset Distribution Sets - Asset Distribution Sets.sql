/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Distribution%20Sets%20-%20Asset%20Distribution%20Sets.sql $:
 * $Id: Manage Asset Distribution Sets - Asset Distribution Sets.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select DISTRIBUTIONSETEO.name RES_NAME
,DISTRIBUTIONSETEO.DESCRIPTION RES_DESCRIPTION
,BOOKCONTROLPEO.BOOK_TYPE_CODE    RES_BOOK
,TO_CHAR(DISTRIBUTIONSETEO.BEGIN_DPIS,'DD-Mon-YYYY') RES_FROM_DATE_PLACED_IN_SERVIC
,to_char(DISTRIBUTIONSETEO.END_DPIS,'DD-Mon-YYYY') RES_TO_DATE_PLACED_IN_SERVICE
  ,DistributionSetEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,DistributionSetEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,DistributionSetEO.CREATED_BY  RSC_CREATED_BY
  ,DistributionSetEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_DISTRIBUTION_SETS DistributionSetEO
,FA_BOOK_CONTROLS BOOKCONTROLPEO
where DISTRIBUTIONSETEO.BOOK_TYPE_CODE = BOOKCONTROLPEO.BOOK_TYPE_CODE
order by DISTRIBUTIONSETEO.name