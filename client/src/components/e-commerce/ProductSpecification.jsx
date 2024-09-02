import PropTypes from 'prop-types';
import { Box, Container, Typography } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({
  specContainer: {
    backgroundColor: theme.palette.background.paper,
    borderRadius: theme.shape.borderRadius,
    boxShadow: theme.shadows[1],
    padding: theme.spacing(3),
    marginBottom: theme.spacing(3),
  },
  specItem: {
    display: 'flex',
    alignItems: 'flex-start',
    padding: theme.spacing(2, 0),
    borderBottom: `1px solid ${theme.palette.divider}`,
    '&:last-child': {
      borderBottom: 'none',
    },
  },
  specName: {
    flexBasis: '30%',
    fontWeight: 600,
    color: theme.palette.text.secondary,
  },
  specValue: {
    flexBasis: '70%',
    color: theme.palette.text.primary,
  },
}));

function ProductSpecification({ overSpecs }) {
  const classes = useStyles();

  return (
    <Container maxWidth="md">
      <Box className={classes.specContainer}>
        <Typography variant="h6" gutterBottom>
          Đặc điểm
        </Typography>
        {overSpecs.map((spec, index) => (
          <Box key={index} className={classes.specItem}>
            <Typography variant="body1" className={classes.specName}>
              {spec.name}
            </Typography>
            <Typography variant="body1" className={classes.specValue}>
              {spec.value}
            </Typography>
          </Box>
        ))}
      </Box>
    </Container>
  );
}

ProductSpecification.propTypes = {
  overSpecs: PropTypes.arrayOf(
    PropTypes.shape({
      name: PropTypes.string,
      value: PropTypes.string
    })
  )
};

export default ProductSpecification;